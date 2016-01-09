require 'rails_helper'

describe Employee do
  it { should have_many(:salaries).dependent(:destroy) }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :start_date }
  it { should validate_presence_of :starting_salary }

  it { should have_db_column(:billable).of_type(:boolean).with_options(default: true) }
  it { should have_db_column(:start_date).of_type(:date) }
  it { should have_db_column(:end_date).of_type(:date) }

  describe '#salary_on' do
    let(:start_date) { Date.parse('2013-7-10') }
    let(:raise_date) { Date.parse('2013-12-10') }
    let(:end_date) { Date.parse('2014-12-31') }

    let(:daisie) { create(:employee, start_date: start_date, end_date: end_date) }

    let!(:starting_salary) { create(:salary, employee: daisie, start_date: start_date) }
    let!(:raise_salary) do
      create(:salary, employee: daisie, start_date: raise_date, annual_amount: '900')
    end

    it 'returns nil, given date before employee has started' do
      expect(daisie.salary_on(start_date - 5)).to be_nil
    end

    it 'returns nil, given date after employee has left' do
      expect(daisie.salary_on(end_date + 5)).to be_nil
    end

    it "returns correct salary, given employee's salary start_date" do
      expect(daisie.salary_on(raise_date)).to eq raise_salary.annual_amount
    end

    it 'returns correct salary, given a date later than latest salary start_date' do
      expect(daisie.salary_on(raise_date + 5)).to eq raise_salary.annual_amount
    end
    it 'returns correct salary, given a date between two salary `start_date`s' do
      expect(daisie.salary_on(raise_date - 5)).to eq starting_salary.annual_amount
    end
  end

  describe '#ending_salary' do
    let(:employee) { create :employee, end_date: end_date }
    let!(:salary) { create :salary, employee: employee }
    let!(:raise_salary) { create :salary, employee: employee, start_date: salary.start_date + 5 }

    context 'no end date' do
      let(:end_date) { nil }

      it 'returns nil' do
        expect(employee.ending_salary).to be_nil
      end
    end

    context 'has end date' do
      let(:end_date) { Time.zone.today + 5 }

      it 'returns latest salary' do
        expect(employee.ending_salary).to eq raise_salary.annual_amount
      end
    end
  end

  describe '#weighted_years_experience' do
    context 'employee had no prior experience' do
      let!(:daisie) { create :employee, start_date: daisie_start_date, end_date: daisie_end_date }
      let(:daisie_start_date) { Date.parse('2012-1-1') }

      context 'employee has left (has an end date)' do
        let(:daisie_end_date) { Date.parse('2014-7-1') }
        it 'returns number of years (decimal) between start and end date' do
          expect(daisie.weighted_years_experience).to be_within(0.05).of 2.5
        end
      end

      context 'current employee (has no end date)' do
        let(:daisie_end_date) { nil }
        let(:expected_weighted_years_experience) { (Time.zone.today - daisie_start_date) / 365.0 }
        it "returns number of years (decimal) since employee's start date" do
          expect(daisie.weighted_years_experience).to eq(expected_weighted_years_experience)
        end
      end
    end

    context 'employee has prior experience' do
      let!(:daisie) do
        create :employee,
               start_date: Date.parse('2012-1-1'),
               end_date: Date.parse('2014-7-1'),
               direct_experience: 12,
               indirect_experience: 12
      end

      it 'counts half of direct experience, quarter of indirect experience' do
        # 2.5 years experience here, equivalent of .75 years experience prior
        expect(daisie.weighted_years_experience).to be_within(0.05).of 3.25
      end
    end
  end

  describe '#employed_on?' do
    let(:start_date) { Date.parse('2013-1-1') }
    let(:employee) { create :employee, start_date: start_date, end_date: end_date }

    context 'employee has end_date' do
      let(:end_date) { Date.parse('2014-6-1') }

      it "returns false before employee's start date" do
        expect(employee.employed_on?(start_date - 1)).to be false
      end
      it "returns false after employee's end date" do
        expect(employee.employed_on?(end_date + 1)).to be false
      end

      it 'returns true between start and end date' do
        expect(employee.employed_on?(end_date - 1)).to be true
      end
      it 'returns true on start date' do
        expect(employee.employed_on?(start_date)).to be true
      end
      it 'returns true on end date' do
        expect(employee.employed_on?(end_date)).to be true
      end
    end

    context 'employee has no end_date' do
      let(:end_date) { nil }
      it 'returns true after start date' do
        expect(employee.employed_on?(Time.zone.today)).to be true
      end
    end
  end

  describe '#salary_data' do
    let(:start_date) { Date.parse '2001-10-10' }
    let(:raise_date) { Date.parse '2002-10-10' }

    let(:employee) do
      create :employee, first_name: 'Joan',
                        starting_salary: 100,
                        start_date: start_date,
                        end_date: end_date
    end

    let!(:raise) { create :salary, employee: employee, start_date: raise_date, annual_amount: 200 }
    let(:last_pay_date) { end_date || Time.zone.today }

    let(:expected_salary_data) do
      [
        { c: [start_date, 100] },
        { c: [raise_date - 1, 100] },
        { c: [raise_date, 200] },
        { c: [last_pay_date, 200] }
      ]
    end

    context 'current employee' do
      let(:end_date) { nil }
      it 'returns ordered set of dates and salary on those dates' do
        expect(employee.salary_data).to eql(expected_salary_data)
      end
    end

    context 'past employee' do
      let(:end_date) { Date.parse '2003-10-10' }
      it 'returns ordered set of dates and salary on those dates' do
        expect(employee.salary_data).to eql(expected_salary_data)
      end
    end

    context 'with future raise' do
      let(:end_date) { nil }
      let(:raise_date) { Time.zone.today + 1.week }

      let(:expected_salary_data) do
        [
          { c: [start_date, 100] },
          { c: [raise_date - 1, 100] },
          { c: [raise_date, 200] }
        ]
      end

      it 'future raise date comes last' do
        expect(employee.salary_data).to eql(expected_salary_data)
      end
    end
  end

  context 'scopes' do
    let!(:started_today) { create :employee, start_date: Time.zone.today }
    let!(:leaving_today) { create :employee, end_date: Time.zone.today }
    let!(:gave_notice) { create :employee, end_date: Time.zone.today + 7 }

    let!(:past_employee) { create :employee, end_date: Time.zone.today - 7 }
    let!(:not_started) { create :employee, start_date: Time.zone.today + 14 }

    describe 'current' do
      it 'returns collection of employees employed today' do
        expect(Employee.current.sort).to eq [gave_notice, started_today, leaving_today].sort
      end
    end

    describe 'past_or_current' do
      let(:expected_employees) { [past_employee, gave_notice, started_today, leaving_today] }
      it 'returns all past or current employees' do
        expect(Employee.past_or_current.sort).to eq expected_employees.sort
      end
    end
    describe 'current_or_future' do
      let(:expected_employees) { [gave_notice, started_today, leaving_today, not_started] }
      it 'returns all current OR future employees' do
        expect(Employee.current_or_future.sort).to eq expected_employees.sort
      end
    end
  end
end

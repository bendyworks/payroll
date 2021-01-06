# frozen_string_literal: true

require 'rails_helper'

describe Employee do
  it { should have_many(:salaries).dependent(:destroy) }
  it { should have_many(:tenures).dependent(:destroy) }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :starting_salary }

  it { should have_db_column(:billable).of_type(:boolean).with_options(default: true) }
  it { should have_db_column(:notes).of_type(:text) }

  describe '#display_name' do
    let(:employee) { create :employee, first_name: "Daisy", last_name: "Duck" }
    it 'returns first and last name' do
      expect(employee.display_name).to eq("#{employee.first_name} #{employee.last_name}")
    end
  end

  describe '#last_raise_date' do
    let(:start_date) { 4.months.ago.to_date }
    let(:first_raise_date) { 3.months.ago.to_date }
    let(:second_raise_date) { 2.months.ago.to_date }
    let(:third_raise_date) { 1.months.ago.to_date }

    let(:employee) { create :employee, starting_salary: 1_000, tenures_attributes: [{start_date: start_date}] }
    let(:last_raise_date) { employee.reload.last_raise_date }

    context 'current employee' do
      context 'with no raises' do
        it 'returns start date' do
          expect(last_raise_date).to eq(start_date)
        end
      end
      context 'with one raise' do
        let!(:only_raise) { create :salary, employee: employee, start_date: first_raise_date }
        it 'returns starting salary' do
          expect(last_raise_date).to eq(first_raise_date)
        end
      end
      context 'with two raises' do
        let!(:first_raise) do
          create :salary, employee: employee, start_date: first_raise_date
        end

        let!(:second_raise) do
          create :salary, employee: employee, start_date: second_raise_date
        end

        it 'returns first raise' do
          expect(last_raise_date).to eq(second_raise_date)
        end
      end
      context 'with three raises' do
        let!(:first_raise) do
          create :salary, employee: employee, start_date: first_raise_date
        end

        let!(:second_raise) do
          create :salary, employee: employee, start_date: second_raise_date
        end

        let!(:third_raise) do
          create :salary, employee: employee, start_date: third_raise_date
        end

        it 'returns second raise' do
          expect(last_raise_date).to eq(third_raise_date)
        end
      end
    end
  end

  describe '#previous_pay' do
    let(:employee) { create :employee, starting_salary: 1_000 }
    let(:previous_pay) { employee.reload.previous_pay }

    context 'current employee' do
      context 'with no raises' do
        it 'returns nil' do
          expect(previous_pay).to be_nil
        end
      end
      context 'with one raise' do
        let!(:only_raise) { create :salary, employee: employee, annual_amount: 2_000 }
        it 'returns starting salary' do
          expect(previous_pay).to eq(1_000)
        end
      end
      context 'with two raises' do
        let!(:first_raise) do
          create :salary, employee: employee, annual_amount: 2_000, start_date: 3.months.ago
        end

        let!(:second_raise) do
          create :salary, employee: employee, annual_amount: 3_000, start_date: 2.months.ago
        end

        it 'returns first raise' do
          expect(previous_pay).to eq(2_000)
        end
      end
      context 'with three raises' do
        let!(:first_raise) do
          create :salary, employee: employee, annual_amount: 2_000, start_date: 3.months.ago
        end

        let!(:second_raise) do
          create :salary, employee: employee, annual_amount: 3_000, start_date: 2.months.ago
        end

        let!(:third_raise) do
          create :salary, employee: employee, annual_amount: 4_000, start_date: 1.months.ago
        end

        it 'returns second raise' do
          expect(previous_pay).to eq(3_000)
        end
      end
    end
  end

  describe '#display_pay' do
    let(:start_date) { Date.parse('2015-08-07') }
    let(:employee) { create :employee, tenures_attributes: [{start_date: start_date}] }

    let!(:starting_salary) do
      create(:salary, employee: employee, start_date: start_date, annual_amount: pay)
    end

    context 'when pay is a whole number of thousands' do
      let(:pay) { 73_000 }
      it 'returns annual pay in K without fractional part' do
        expect(employee.display_pay).to eq('$73K')
      end
    end

    context 'when pay is not a whole number of thousands' do
      let(:pay) { 73_500 }
      it 'returns annual pay in K with fractional part' do
        expect(employee.display_pay).to eq('$73.5K')
      end
    end
  end

  describe '#salary_on' do
    let(:start_date) { Date.parse('2013-7-10') }
    let(:raise_date) { Date.parse('2013-12-10') }
    let(:end_date) { Date.parse('2014-12-31') }

    let(:daisie) { create(:employee, tenures_attributes: [{start_date: start_date, end_date: end_date}]) }

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
    let(:employee) do
      build(:employee).tap do |employee|
        employee.tenures = [build(:tenure, end_date: end_date)]
        employee.save
      end
    end
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
      let!(:daisie) { create :employee, tenures_attributes: [{start_date: daisie_start_date, end_date: daisie_end_date}] }
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
               tenures_attributes: [{
                start_date: Date.parse('2012-1-1'),
                end_date: Date.parse('2014-7-1'),
               }],
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
    let(:employee) { create :employee, tenures_attributes: [{start_date: start_date, end_date: end_date}] }

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
                        tenures_attributes: [{
                          start_date: start_date,
                          end_date: end_date
                        }]
    end

    let!(:raise) { create :salary, employee: employee, start_date: raise_date, annual_amount: 200 }
    let(:last_pay_date) { end_date || Time.zone.today }

    let(:expected_salary_data) do
      date_for_js = ->(date) { date.to_time.to_f * 1000 }

      [
        { c: [date_for_js.call(start_date), 100] },
        { c: [date_for_js.call(raise_date - 1), 100] },
        { c: [date_for_js.call(raise_date), 200] },
        { c: [date_for_js.call(last_pay_date), 200] }
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
        date_for_js = ->(date) { date.to_time.to_f * 1000 }

        [
          { c: [date_for_js.call(start_date), 100] },
          { c: [date_for_js.call(raise_date - 1), 100] },
          { c: [date_for_js.call(raise_date), 200] }
        ]
      end

      it 'future raise date comes last' do
        expect(employee.salary_data).to eql(expected_salary_data)
      end
    end
  end

  context 'scopes' do
    let!(:started_today) do
      build(:employee, first_name: 'Started Today').tap do |employee|
        employee.tenures = [build(:tenure, start_date: Time.zone.today)]
        employee.save
      end
    end
    let!(:leaving_today) do
      build(:employee, first_name: 'Leaving Today').tap do |employee|
        employee.tenures = [build(:tenure, end_date: Time.zone.today)]
        employee.save
      end
    end
    let!(:gave_notice) do
      build(:employee, first_name: 'Gave Notice').tap do |employee|
        employee.tenures = [build(:tenure, end_date: Time.zone.today + 7)]
        employee.save
      end
    end

    let!(:past_employee) do
      build(:employee, first_name: 'Past Employee').tap do |employee|
        employee.tenures = [build(:tenure, end_date: Time.zone.today - 7)]
        employee.save
      end
    end
    let!(:not_started) do
      build(:employee, first_name: 'Not Started').tap do |employee|
        employee.tenures = [build(:tenure, start_date: Time.zone.today + 14)]
        employee.save
      end
    end
    let!(:returned) do
      build(:employee, first_name: 'Returned').tap do |employee|
        employee.tenures = [build(:tenure, start_date: Time.zone.today - 14,
                                           end_date: Time.zone.today - 7),
                            build(:tenure, start_date: Time.zone.today)]
        employee.save
      end
    end
    let!(:returning_soon) do
      build(:employee, first_name: 'Returning Soon').tap do |employee|
        employee.tenures = [build(:tenure, start_date: Time.zone.today - 14,
                                           end_date: Time.zone.today - 7),
                            build(:tenure, start_date: Time.zone.today + 7)]
        employee.save
      end
    end
    let!(:left_twice) do
      build(:employee, first_name: 'Left Twice').tap do |employee|
        employee.tenures = [build(:tenure, start_date: Time.zone.today - 21,
                                           end_date: Time.zone.today - 14),
                            build(:tenure, start_date: Time.zone.today - 7,
                                           end_date: Time.zone.today - 1)]
        employee.save
      end
    end

    describe 'current' do
      it 'returns collection of employees employed today' do
        expect(Employee.current.sort).to eq [gave_notice, started_today, leaving_today, returned].sort
      end
    end

    describe 'non_current' do
      it 'returns collection of employees not employed today' do
        expect(Employee.non_current.sort).to eq [past_employee, not_started, returning_soon, left_twice].sort
      end
    end

    describe 'past' do
      let(:expected_employees) { [past_employee.first_name, left_twice.first_name] }

      it 'returns all past employees' do
        expect(Employee.past.map(&:first_name).sort).to eq expected_employees.sort
      end
    end

    describe 'past_or_current' do
      let(:expected_employees) do
        [
          past_employee.first_name,
          gave_notice.first_name,
          started_today.first_name,
          leaving_today.first_name,
          returned.first_name,
          left_twice.first_name
        ]
      end

      it 'returns all past or current employees' do
        expect(described_class.past_or_current.map(&:first_name).sort).to eq expected_employees.sort
      end
    end

    describe 'current_or_future' do
      let(:expected_employees) {
        [gave_notice, started_today, leaving_today, not_started, returned, returning_soon]
      }
      it 'returns all current OR future employees' do
        expect(Employee.current_or_future.sort).to eq expected_employees.sort
      end
    end
  end
end

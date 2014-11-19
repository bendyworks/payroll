require 'rails_helper'

RSpec.describe Employee, :type => :model do
  it { should have_many :salaries }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :start_date }

  it { should have_db_column(:billable).of_type(:boolean) }
  it { should have_db_column(:start_date).of_type(:date) }
  it { should have_db_column(:end_date).of_type(:date) }

  describe 'salary_on' do
    let(:start_date) { Date.parse('2013-7-10') }
    let(:raise_date) { Date.parse('2013-12-10') }
    let(:end_date) { Date.parse('2014-12-31') }

    let(:daisie) { create(:employee, start_date: start_date, end_date: end_date) }

    let!(:starting_salary) { create(:salary, employee: daisie, start_date: start_date) }
    let!(:raise_salary) { create(:salary, employee: daisie, start_date: Date.parse('2013-12-10'), annual_amount: '900') }

    it 'returns nil, given date before employee has started' do
      expect(daisie.salary_on(start_date - 5)).to be_nil
    end

    it 'returns nil, given date after employee has left' do
      expect(daisie.salary_on(end_date + 5)).to be_nil
    end

    it "returns correct salary, given employee's salary start_date" do
      expect(daisie.salary_on(raise_date)).to eq raise_salary.annual_amount
    end

    it "returns correct salary, given a date later than latest salary start_date" do
      expect(daisie.salary_on(raise_date + 5)).to eq raise_salary.annual_amount
    end
    it "returns correct salary, given a date between two salary `start_date`s" do
      expect(daisie.salary_on(raise_date - 5)).to eq starting_salary.annual_amount
    end
  end

  describe 'years_experience' do
    let!(:daisie) { create :employee, start_date: daisie_start_date, end_date: daisie_end_date }
    let(:daisie_start_date) { Date.parse('2012-1-1') }

    context 'employee has left (has an end date)' do
      let(:daisie_end_date) { Date.parse('2014-7-1') }

      it "returns number of years (decimal) between start and end date" do
        expect(daisie.years_experience).to be_within(0.05).of 2.5
      end
    end

    context 'current employee (has no end date)' do
      let(:daisie_end_date) { nil }

      it "returns number of years (decimal) since employee's start date" do
        expect(daisie.years_experience).to eq (Date.today - daisie_start_date)/365.0
      end
    end
  end

  describe 'employed_on?' do
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

      it "returns true between start and end date" do
        expect(employee.employed_on?(end_date - 1)).to be true
      end
      it "returns true on start date" do
        expect(employee.employed_on?(start_date)).to be true
      end
      it "returns true on end date" do
        expect(employee.employed_on?(end_date)).to be true
      end
    end

    context 'employee has no end_date' do
      let(:end_date) { nil }
      it "returns true after start date" do
        expect(employee.employed_on?(Date.today)).to be true
      end
    end
  end

  describe 'current' do
    let!(:normal_employee) { create :employee }
    let!(:gave_notice) { create :employee, end_date: Date.today + 7 }
    let!(:past_employee) { create :employee, end_date: Date.today - 7 }
    let!(:not_started) { create :employee, start_date: Date.today + 14 }

    it 'returns collection of employees employed today' do
      expect(Employee.current.sort).to eq [gave_notice, normal_employee].sort
    end
  end
end

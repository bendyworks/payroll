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
    let(:daisie) { Employee.create!(first_name: 'Daisie',
                        last_name: 'Duck',
                        start_date: Date.parse('2013-7-10'),
                        end_date: Date.parse('2014-12-31'),
                        billable: true) }
    let!(:daisie_starting_salary) { Salary.create!(employee: daisie,
                                                  start_date: Date.parse('2013-7-10'),
                                                  annual_amount: '45000')}
    let!(:daisie_raise_salary) { Salary.create!(employee: daisie,
                                                  start_date: Date.parse('2013-12-10'),
                                                  annual_amount: '55000')}

    it 'returns nil, given date before employee has started' do
      expect(daisie.salary_on(Date.parse('2013-1-1'))).to be_nil
    end

    it 'returns nil, given date after employee has left' do
      expect(daisie.salary_on(Date.parse('2015-1-1'))).to be_nil
    end

    it "returns correct salary, given employee's salary start_date" do
      expect(daisie.salary_on(Date.parse('2013-12-10'))).to eq 55000
    end

    it "returns correct salary, given a date later than latest salary start_date" do
      expect(daisie.salary_on(Date.parse('2014-1-1'))).to eq 55000
    end
    it "returns correct salary, given a date between two salary `start_date`s" do
      expect(daisie.salary_on(Date.parse('2013-10-10'))).to eq 45000
    end
  end

  describe 'years_experience' do
    let(:daisie_start_date) { Date.parse('2012-1-1') }

    context 'employee has left (has an end date)' do
      let(:daisie_end_date) { Date.parse('2014-7-1') }
      let!(:daisie) { Employee.create!(first_name: 'Daisie',
                          last_name: 'Duck',
                          start_date: daisie_start_date,
                          end_date: daisie_end_date) }

      it "returns number of years (decimal) between start and end date" do
        expect(daisie.years_experience).to be_within(0.05).of 2.5
      end
    end

    context 'current employee (has no end date)' do
      let!(:daisie) { Employee.create!(first_name: 'Daisie',
                          last_name: 'Duck',
                          start_date: daisie_start_date) }

      it "returns number of years (decimal) since employee's start date" do
        expect(daisie.years_experience).to eq (Date.today - daisie_start_date)/365.0
      end
    end
  end
end

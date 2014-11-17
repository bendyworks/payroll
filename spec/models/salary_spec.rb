require 'rails_helper'

RSpec.describe Salary, :type => :model do
  it { should belong_to(:employee).dependent(:destroy) }
  it { should validate_presence_of :start_date }
  it { should validate_presence_of :annual_amount }

  describe 'ordered_dates' do
    let(:daisie_date) { Date.parse('2013-7-10') }
    let(:donald_date) { Date.parse('2013-4-10') }
    let(:minnie_date) { Date.parse('2013-5-10') }

    let(:daisie) { Employee.create!(first_name: 'Daisie',
                        last_name: 'Duck',
                        start_date: daisie_date,
                        billable: true) }
    let(:donald) { Employee.create!(first_name: 'Donald',
                        last_name: 'Duck',
                        start_date: donald_date,
                        billable: true) }
    let(:minnie) { Employee.create!(first_name: 'Minnie',
                        last_name: 'Mouse',
                        start_date: minnie_date,
                        billable: true) }

    let!(:daisie_starting_salary) { Salary.create!(employee: daisie,
                                                  start_date: daisie_date,
                                                  annual_amount: '45000')}
    let!(:donald_starting_salary) { Salary.create!(employee: donald,
                                                  start_date: donald_date,
                                                  annual_amount: '45000')}
    let!(:minnie_starting_salary) { Salary.create!(employee: minnie,
                                                  start_date: minnie_date,
                                                  annual_amount: '45000')}

    it 'returns all salary dates in order' do
      expect(Salary.ordered_dates).to eq([donald_date, minnie_date, daisie_date])
    end

    it 'removes duplicate dates' do
      mickey = Employee.create!(first_name: 'Mickey',
                                last_name: 'Mouse',
                                start_date: minnie_date, #duplicate of minnie
                                billable: true)

      Salary.create!(employee: mickey,
                     start_date: minnie_date, #duplicate
                     annual_amount: '45000')

      expect(Salary.ordered_dates).to eq([donald_date, minnie_date, daisie_date])
    end
  end
end

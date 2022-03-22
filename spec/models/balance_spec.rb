require 'rails_helper'

RSpec.describe Balance, type: :model do
  describe 'validation' do
    describe 'date' do
      let(:balance) { build :balance, date: date, amount: 15.75 }
      context 'passed 04/13/2009' do
        let(:date) { '2009/04/13'.to_date }
        it 'is valid' do
          expect(balance).to be_valid
        end
      end
      context 'passed 14/12/2009' do
        let(:date) { '2009/04/12'.to_date }
        it 'is not valid' do
          expect(balance).to_not be_valid
        end
      end
    end
  end
end
require 'rails_helper'

RSpec.describe Account, type: :model do
  describe '#balance_on' do
    let(:account) { create :account }
    let(:date) { Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now, excepted: Date.today) }
    let(:amount) { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    let!(:balance) { create :balance, account: account, date: date, amount: amount }

    context 'passed date with a balance' do
      it 'returns the amount of the balance on that date' do
        expect(account.balance_on(date)).to eq(amount)
      end
    end
    context 'passed date without a balance' do
      it 'returns nil' do
        expect(account.balance_on(date + 1.day)).to be_nil
      end
    end
  end
end
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should belong_to :account_type }
  it { should have_many :balances }

  describe '#balance_on' do
    let(:account) { create :account }
    let(:date) { '2015/09/15'.to_date }
    let(:amount) { 150.63.to_d }
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

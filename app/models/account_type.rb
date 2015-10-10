class AccountType < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  TYPES = ['Checking',
           'Credit Card',
           'Savings',
           'Accounts Receivable',
           'Accounts Payable',
           'Loan',
           'Line of Credit',
           'WIP',
           'Prepaid']

  def self.seed
    TYPES.each do |name|
      AccountType.find_or_create_by name: name
    end
  end
end

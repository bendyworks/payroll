class Account < ActiveRecord::Base
  belongs_to :account_type
  has_many :balances
  validates :name, presence: true, uniqueness: true

  def balance_on(date)
    self.balances.find_by(date: date).try(:amount)
  end
end

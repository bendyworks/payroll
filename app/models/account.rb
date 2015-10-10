class Account < ActiveRecord::Base
  belongs_to :account_type
  has_many :balances
  validates :name, presence: true, uniqueness: true
end

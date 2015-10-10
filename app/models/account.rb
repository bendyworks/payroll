class Account < ActiveRecord::Base
  belongs_to :account_type
  validates :name, presence: true, uniqueness: true
end

class Balance < ActiveRecord::Base
  belongs_to :account
  validates :account_id, presence: true
  validates_uniqueness_of :date, scope: :account_id
end

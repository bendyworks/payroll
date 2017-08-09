# frozen_string_literal: true

class Balance < ActiveRecord::Base
  COMPANY_START_DATE = '2009/04/13'.to_date

  belongs_to :account
  validates :account_id, presence: true
  validates :date, uniqueness: { scope: :account_id }
  validate :date_not_older_than_bendyworks

  def self.ordered_dates
    select('distinct date').order('date').map(&:date)
  end

  private

  def date_not_older_than_bendyworks
    if date
      errors.add(:date, 'cannot be older than company') if date < COMPANY_START_DATE
    end
  end
end

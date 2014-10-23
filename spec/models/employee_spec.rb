require 'rails_helper'

RSpec.describe Employee, :type => :model do
  it { should have_many :salaries }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :start_date }

  it { should have_db_column(:billable).of_type(:boolean) }
  it { should have_db_column(:start_date).of_type(:date) }
  it { should have_db_column(:end_date).of_type(:date) }
end

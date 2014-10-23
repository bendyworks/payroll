require 'rails_helper'

RSpec.describe Employee, :type => :model do
  it { should have_many :salaries }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :billable }
end

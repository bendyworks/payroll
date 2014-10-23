require 'rails_helper'

RSpec.describe Salary, :type => :model do
  it { should belong_to :employee }
  it { should validate_presence_of :start_date }
  it { should validate_presence_of :annual_amount }
end

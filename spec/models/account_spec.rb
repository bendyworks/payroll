require 'rails_helper'

RSpec.describe Account, type: :model do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should belong_to :account_type }
end

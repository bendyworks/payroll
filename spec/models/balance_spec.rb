require 'rails_helper'

RSpec.describe Balance, type: :model do
  it { should belong_to :account }
  it { should validate_presence_of :account_id }
  it { should validate_uniqueness_of(:date).scoped_to(:account_id) }
end

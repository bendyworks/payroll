# frozen_string_literal: true

require 'rails_helper'

describe Tenure do  
  it { should belong_to :employee }
  it { should validate_presence_of :start_date }
  it { should validate_presence_of :employee }

  it 'validates employee salary start dates unique' do
    create :tenure
    should validate_uniqueness_of(:start_date).scoped_to(:employee_id)
  end
end
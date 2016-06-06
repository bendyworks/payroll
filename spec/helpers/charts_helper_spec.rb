require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ChartsHelper. For example:
#
# describe ChartsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ChartsHelper, type: :helper do
  describe 'future_employee_exists?' do
    subject { future_employee_exists? }
    context 'with future employee' do
      before do
        create :employee, start_date: 1.week.from_now
      end

      it 'returns true' do
        expect(subject).to eq(true)
      end
    end
    context 'without future employee' do
      it 'returns false' do
        expect(subject).to eq(false)
      end
    end
  end
end

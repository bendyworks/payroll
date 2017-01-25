# frozen_string_literal: true

PLANNING_FIELDS = [
  :first_name,
  :last_name,
  :display_pay,
  :previous_pay
].freeze

Then(/^I see planning information for those employees$/) do
  within '#planning' do
    Employee.all.each do |employee|
      within "#employee_#{employee.id}" do
        PLANNING_FIELDS.each do |field|
          within "##{field}" do
            expect(page).to have_content(employee.send(field))
          end
        end
        within '#last_raise_date' do
          expect(page).to have_content(employee.last_raise_date.strftime('%m/%d/%y'))
        end
      end
    end
  end
end

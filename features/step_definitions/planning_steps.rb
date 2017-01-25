# frozen_string_literal: true

PLANNING_FIELDS = [
  :first_name,
  :last_name,
  :display_pay,
  :previous_pay,
  :last_raise_date,
  :planning_raise_date,
  :planning_raise_salary,
  :planning_notes
].freeze

Then(/^I see planning information for those employees$/) do
  within '#planning' do
    Employee.all.each do |employee|
      within "#employee_#{employee.id}" do
        PLANNING_FIELDS.each do |field|
          expected_content = employee.send(field)
          expected_content = expected_content.strftime('%m/%d/%y') if expected_content.class == Date

          within "##{field}" do
            expect(page).to have_content(expected_content)
          end
        end
      end
    end
  end
end

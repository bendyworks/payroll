# frozen_string_literal: true

PLANNING_FIELDS = [
  :first_name,
  :last_name,
  :display_pay,
  :previous_pay,
  :last_raise_date
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

        within '#six_months' do
          expect(page).to have_content(employee.last_raise_date + 6.months)
        end

        within '#twelve_months' do
          expect(page).to have_content(employee.last_raise_date + 12.months)
        end
      end
    end
  end
end

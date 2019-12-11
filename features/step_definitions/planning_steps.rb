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

          verify_field_value field, expected_content unless expected_content.nil?
        end
      end
    end
  end
end

When(/^I edit planning fields in place$/) do
  in_place_edit 'planning_raise_date', '01/14/2018'
  in_place_edit 'planning_raise_salary', '15976'
  in_place_edit 'planning_notes', 'What do you think?'
end

Then(/^I see my planning field changes$/) do
  verify_field_value 'planning_raise_date', '01/14/2018'
  verify_field_value 'planning_raise_salary', '15976'
  verify_field_value 'planning_notes', 'What do you think?'
end

private

def in_place_edit(field, value)
  find("##{field} > span").click
  fill_in field, with: value
  page.find('body').click # trigger blur
end

def verify_field_value(field, expected_content)
  within "##{field}" do
    expect(page).to have_content(expected_content)
  end
end

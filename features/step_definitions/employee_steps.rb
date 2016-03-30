Given(/^employee$/) do
  @employee ||= create :employee
end

Given(/^employees$/) do
  create_list :employee, 5
end

Given(/^employee "([^"]*)" exists$/) do |employee_name|
  @employee = create(:employee, first_name: employee_name)
end

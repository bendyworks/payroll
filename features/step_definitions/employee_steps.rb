Given(/^employee$/) do
  @employee ||= create :employee
end

Given(/^employees$/) do
  create_list :employee, 5
end

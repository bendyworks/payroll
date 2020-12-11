# frozen_string_literal: true

Given(/^employee$/) do
  @employee ||= create :employee
end

Given(/^employees$/) do
  create_list :employee, 5
end

Given(/^3 employees$/) do
  create(:employee,
         first_name: 'Alfred',
         last_name: 'Anderson',
         starting_salary: 10_000,
         planning_raise_date: 1.week.from_now,
         planning_raise_salary: 20_000,
         planning_notes: 'Any thoughts?')

  create(:employee,
         first_name: 'Betsy',
         last_name: 'Buelow',
         starting_salary: 20_000,
         planning_raise_date: 2.weeks.from_now,
         planning_raise_salary: 30_000,
         planning_notes: 'Best move?')

  create(:employee,
         first_name: 'Charles',
         last_name: 'Canuck',
         starting_salary: 30_000,
         planning_raise_date: 3.weeks.from_now,
         planning_raise_salary: 40_000,
         planning_notes: 'Can this wait until June')
end

Given(/^employee "([^"]*)"$/) do |employee_name|
  @employee = create(:employee, first_name: employee_name)
end

Given(/^former employee "([^"]*)"/) do |employee_name|
  create(:employee,
  first_name: employee_name,
  start_date: '03/01/2016',
  end_date: '03/01/2018')
end

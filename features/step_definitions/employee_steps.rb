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

Given(/current support employee Juniper/) do
  create(:employee, :current, :support, first_name: "Juniper")
end

Given('past support employee George') do
  create(:employee, :past, :billable, first_name: "George")
end

Given('current billable Mary') do
  create(:employee, :current, :billable, first_name: "Mary")
end

Given('past billable Frida') do
  create(:employee, :past, :billable, first_name: "Frida")
end

Given(/^employee "([^"]*)"$/) do |employee_name|
  @employee = create(:employee, first_name: employee_name)
end

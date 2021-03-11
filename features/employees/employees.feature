Feature: Administer employees
  In order to maintain a list of employees to track and graph
  As a user
  I want to create, read, update, and delete employees

  Scenario: Add employee
    Given I'm logged in
    When I follow "Employees"
      And I follow "Add employee"
    Then I should see "Add New Employee"

    When I fill in "First name" with "Scrooge"
      And I fill in "Last name" with "McDuck"
      And I fill in "Start date" with "03/01/2016"
      And I fill in "Starting salary annual amount" with "10000.00"
      And I fill in "Notes" with "New employee"
      And I press "Save"
    Then I see "Employee successfully created."

  Scenario: Update employee notes
    Given employee "Scrooge"
      And I'm logged in
      And I follow "Employees"
      And I follow "Scrooge"
      And I press "Edit"
    When I fill in "Notes" with "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
      And I press "Save"
    Then I should see a pre tag
      And I should see "Notes"
      And I should see "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."

  Scenario: Add back employee
    Given former employee "Luke"
      And I'm logged in
      And I follow "Employees"
      And I follow "Luke"
      And I press "Edit"
    Then I should see "New start date"

    When I fill in "New start date" with "01/12/2020"
      And I press "Save"
    Then I should see "Dec 1, 2020"

    When I press "Edit"
    Then I should see "2nd start date"
      And I should see "2nd end date"
      And I should see "1st start date"
      And I should see "1st end date"

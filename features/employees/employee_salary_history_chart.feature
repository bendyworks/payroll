Feature: Single Employee Salary Chart
  In order to see trends over time
  As a user of the app
  I want to see a chart of an employee's salary over time

  @javascript
  Scenario: user sees single employee salary history chart
    Given employee
      And I'm logged in
    When I'm on that employee page
    Then their salary history chart is present

Feature: Employee Salaries Chart
  In order to see trends over time
  As a user of the app
  I want to see a chart of employee salaries over time

  @javascript
  Scenario: user sees employee salaries chart
    Given employees
      And I'm logged in
    When I'm on the salaries chart page
    Then the salaries chart is present
      And current employment status is checked

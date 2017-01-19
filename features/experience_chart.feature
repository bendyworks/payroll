Feature: Experience Chart
  In order to see trends over time
  As a user of the app
  I want to see a chart of employee experience versus salary

  @javascript
  Scenario: user sees experience chart
    Given employees
    When I'm on the experience chart page
    Then the experience chart is present
      And current employment status is checked

  @javascript
  Scenario: user clicks on employee in experience chart legend
    Given employees
      And employee
      And I'm logged in
    When I'm on the experience chart page
      And I click on employee's name
    Then I should be on employee's page

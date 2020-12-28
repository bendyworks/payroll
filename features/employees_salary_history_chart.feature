Feature: Employee Salaries Chart
  In order to see trends over time
  As a user of the app
  I want to see a chart of employee salaries over time

  @javascript
  Scenario: user sees employee salaries chart
    Given employees
    When I'm on the salaries chart page
    Then the salaries chart is present
      And current employment status is checked

  @javascript
  Scenario: user clicks on employee in salaries chart legend
    Given employees
      And employee
      And I'm logged in
    When I'm on the salaries chart page
      And I click on employee's name
    Then I should be on employee's page

  @javascript
  Scenario: user filters employees by status
    Given current support employee Juniper
      And past support employee George
      And current billable Mary
      And past billable Frida
      And I'm logged in
    When I'm on the salaries chart page
      And I apply "Past" only
    Then I should not see "Juniper"
    Then I should not see "Mary"
    Then I should see "George"
    Then I should see "Frida"

    When I apply "Current" only
    Then I should see "Juniper"
    Then I should see "Mary"
    Then I should not see "George"
    Then I should not see "Frida"


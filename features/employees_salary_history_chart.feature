Feature: Employee Salaries Chart

@javascript
Scenario: user sees employee salaries chart
  Given employees
    And I'm logged in
  When I'm on the salaries chart page
  Then the salaries chart is present
    And current employment status is checked

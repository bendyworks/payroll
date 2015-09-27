Feature: Salary History Chart

@javascript
Scenario: user sees employees salary history chart
  Given employees
    And I'm logged in
  When I'm on the salary history chart page
  Then the salary history chart is present

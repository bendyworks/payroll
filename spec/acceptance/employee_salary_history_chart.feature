Feature: Single Employee Salary Chart

@javascript
Scenario: user sees single employee salary history chart
  Given employee
    And I'm logged in
  When I'm on that employee page
  Then their salary history chart is present

Feature: Experience Chart

@javascript
Scenario: user sees experience chart
  Given employees
    And I'm logged in
  When I'm on the experience chart page
  Then the experience chart is present

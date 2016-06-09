Feature: Balances chart
  In order to see trends over time
  As a user of the app
  I want to see a chart of balances and totals over time

  @javascript
  Scenario: user views cashflow graph
    Given accounts
      And balances
      And I'm logged in
    When I'm on the balances chart page
    Then the balances chart is present

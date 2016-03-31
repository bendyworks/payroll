Feature: Home Page
  In order to see an overview of data
  As a user of the app
  I want to see a home page

  @javascript
  Scenario: user sees home page
    Given employees
      And I'm logged in
    When I'm on the homepage
    Then a small salary history chart is present

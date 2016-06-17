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
      And a small experience chart is present

  @javascript
  Scenario: user clicks on small salary history chart
    Given employees
      And I'm logged in
    When I'm on the homepage
      And I click on the small salary history chart
    Then I should be on the salaries page

  @javascript
  Scenario: user clicks on small experience chart
    Given employees
      And I'm logged in
    When I'm on the homepage
      And I click on the small experience chart
    Then I should be on the experience page

Feature: Planning page
  In order to plan what raises to give when
  As an admin
  I want to see convenient planning info

  Scenario: Basic Info
    Given employees
      And I'm logged in
    When I follow "Planning"
    Then I'm on the planning page
      And I see planning information for those employees

Feature: Edit planning fields in place
  In order to capture thinking and discussion on planned raises
  As a user
  I want to edit fields in the planning table

  @javascript
  Scenario: User edits planning field
    Given employee
      And I'm on the planning page
    When I edit planning fields in place
    Then I see my planning field changes

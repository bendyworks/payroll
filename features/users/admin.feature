Feature: Admin Users
  In order to control who can add and delete other users
  As an admin user 
  I want to add and delete other users

  Scenario: View admins
    Given an admin user exists
      And a non-admin user exists
      And I'm logged in
    When I'm on the users page
    Then the admin user should have admin checked
      And the non-admin user should not have admin checked

  Scenario: Single admin
    Given an admin user exists
      And I'm logged in
    When I'm on the users page
    Then the admin user should have admin checked

  @javascript
  Scenario: Admin makes another user an admin
    Given a non-admin user exists
      And I'm logged in
      And I'm on the users page
    When I check the admin button for that user
    Then that user should have admin checked
      And that user should be an admin

  @javascript
  Scenario: Admin makes another user a non-admin
    Given an admin user exists
      And I'm logged in
      And I'm on the users page
    When I uncheck the admin button for that user
    Then that user should not have admin checked
      And that user should not be an admin
Feature: Admin Users
  In order to control who can add and delete other users
  As an admin user 
  I want to add and delete other users

  Scenario: View admins
    Given an admin user exists
      And a non-admin user exists
    When I'm on the users page
    Then the admin user should have admin checked
      And the non-admin user should not have admin checked

  Scenario: Admin makes another user an admin
    Given a non-admin user jake@example.com
      And I'm on the users page
    When I check the admin button for jake@example.com
    Then jake@example.com should have admin checked
      And jake@example.com should be an admin

  Scenario: Admin makes another user a non-admin
    Given an admin user jake@example.com
      And I'm on the admin page
    When I uncheck the admin button for jake@example.com
    Then jake@example.com should not have admin checked
      And jake@example.com should not be an admin
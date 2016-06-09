Feature: Delete User
  In order to remove a users access when they leave Bendyworks
  As an admin
  I want to delete their user account

Scenario: Delete user from system
  Given user "joyce@example.com"
    And I'm logged in
  When I'm on the users page
    And I delete user "joyce@example.com"
  Then I should not see "joyce@example.com" 
  Then "joyce@example.com" should no longer be a user in the database
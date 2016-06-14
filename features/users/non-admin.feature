Feature: Non-Admin User
  In order to control who can add and delete other users
  As an non-admin user 
  I do not want to see the users link

  Scenario:
    Given I'm logged in
      And I'm a non-admin user
    When I'm on the homepage
    Then I do not see the users link
      And I cannot go directly to the users page
      And I cannot submit a POST to make myself an admin
      And I cannot submit a DELETE to delete my user record
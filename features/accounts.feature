Feature: Administer accounts
  In order to maintain a list of accounts to track and graph
  As a user
  I want to create, read, update and delete accounts

  Scenario: Add account
    Given account types
      And I'm logged in
    When I follow "Accounts"
      And I follow "Add account"
      And I fill in "Name" with "UWCU Checking"
      And I select "Checking" from "Type"
      And I press "Save"
    Then I see "Account was successfully created"

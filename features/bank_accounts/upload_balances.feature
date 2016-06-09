Feature: Upload balances
  In order to load much balance data quickly from previous spreadsheets
  As a user
  I want to upload many balances I exported from the old spreadsheet's data tab

Scenario: User uploads balances CSV
  Given accounts
    And I'm logged in
   When I follow "Accounts"
    And I follow "Upload balances CSV"
    And I upload "balances.csv"
  Then I see "Balances successfully uploaded"

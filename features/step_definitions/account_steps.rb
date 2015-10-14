EXAMPLE_ACCOUNTS = { 'City Bank Checking' => 'Checking',
                     'Discover' => 'Credit Card',
                     'City Bank Savings' => 'Savings',
                     'A/R' => 'Accounts Receivable',
                     'A/P' => 'Accounts Payable',
                     'SBA Loan' => 'Loan',
                     'City Bank LOC' => 'Line of Credit',
                     'WIP' => 'WIP',
                     'Prepaid' => 'Prepaid'}

Given(/^account types$/) do
  AccountType.seed
end

Given(/^accounts$/) do
  EXAMPLE_ACCOUNTS.each do |name, type|
    Account.create name: name, account_type: AccountType.find_by_name(type)
  end
end

When(/^I upload "(.*?)"$/) do |file_name|
  attach_file('balances_file', File.expand_path(file_name, Rails.root.join('features', 'support')))
  click_on 'Upload'
end

# frozen_string_literal: true
When(/^I follow "(.*?)"$/) do |link_text|
  click_link link_text
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |label, text|
  fill_in label, with: text
end

When(/^I select "(.*?)" from "(.*?)"$/) do |menu_choice, label|
  select menu_choice, from: label
end

When(/^I press "([^"]*?)"$/) do |button_text|
  click_on button_text
end

Then(/^I see "(.*?)"$/) do |text|
  expect(page.body).to have_text(text)
end

Then(/^I should see "(.*?)"$/) do |target_text|
  expect(page).to have_content(target_text)
end

Then(/^I should not see "(.*?)"$/) do |target_text|
  expect(page).to_not have_content(target_text)
end

Then(/^I should see #(.*?)$/) do |element_id|
  fail "No DOM element exists with id '#{element_id}''" if has_no_css?("\##{element_id}")
end

Then(/^I should see a (.*?) tag$/) do |element_tag|
  fail "No #{element_tag} DOM element exists" if has_no_css?(element_tag.to_s)
end

When(/^I click the "([^"]*)" column header$/) do |column_header|
  header = find(:xpath, '//th', text: column_header)
  raise("Couldn't find #{column_header} column header") unless header
  header.click
end

Then(/^table rows are sorted by (ascending|descending) "([^"]*)"$/) do |direction, column_header|
  direction_symbol = direction == 'ascending' ? '▾' : '▴'
  actual_values = table_column_contents("#{column_header} #{direction_symbol}")

  expected_values = actual_values.sort
  expected_values.reverse! if direction == 'descending'

  expect(actual_values).to eq(expected_values)
end

private

# TODO: refactor
def table_column_contents column_header
  headers = []
  rows = []
  within('thead') do
    all('th').each do |header|
      headers << header.text
    end
  end
  within('tbody') do
    all('tr').each do |row|
      result_row = []
      within(row) do
        all('td').each do |cell|
          result_row << cell.text
        end
      end
      rows << result_row
    end
  end
  column_offset = headers.index(column_header)
  raise "Missing '#{column_header}' from headers: '#{headers}'" if column_offset.nil?
  rows.map{|r| r[column_offset]}
end

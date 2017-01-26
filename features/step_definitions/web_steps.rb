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

When(/^I click the "([^"]*)" column header$/) do |col_header|
  header = find(:xpath, '//th', text: col_header)
  fail("Couldn't find #{col_header} column header") unless header
  header.click
end

Then(/^table rows are sorted by (ascending|descending) "([^"]*)"$/) do |direction, col_header|
  direction_symbol = direction == 'ascending' ? '▾' : '▴'
  actual_values = table_column_contents("#{col_header} #{direction_symbol}")

  expected_values = actual_values.sort
  expected_values.reverse! if direction == 'descending'

  expect(actual_values).to eq(expected_values)
end

private

def table_column_contents(col_header)
  hdrs = table_headers
  fail('Missing headers') if hdrs.empty?

  rows = table_rows
  fail('Missing rows') if rows.empty?

  col_offset = hdrs.index(col_header) || fail("Missing '#{col_header}' from headers: '#{hdrs}'")
  rows.map { |r| r[col_offset] }
end

def table_headers
  within('thead') { all('th').map(&:text) }
end

def table_rows
  within('tbody') do
    all('tr').map do |row|
      within(row) { all('td').map(&:text) }
    end
  end
end

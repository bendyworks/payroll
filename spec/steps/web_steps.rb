step "I follow :link_text" do |link_text|
  click_link link_text
end

step "I fill in :label with :text" do |label, text|
  fill_in label, with: text
end

step "I select :menu_choice from :label" do |menu_choice, label|
  select menu_choice, from: label
end

step "I press :button_text" do |button_text|
  click_on button_text
end

step "I see :text" do |text|
  expect(page.body).to have_text(text)
end

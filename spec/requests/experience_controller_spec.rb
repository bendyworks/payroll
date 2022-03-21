require 'rails_helper'

describe "Experience" do
  before :each do
    sign_in_admin
  end
  
  it "has a experience chart." do
    visit experience_path

    expect(page).to have_css "#experience_chart"
  end

  it "has all the filters on." do
    visit experience_path

    check "Current"
    check "Past"
    check "Future"
    check "Billable"
    check "Support"
    click_submit

    expect(page.find('#employment_current')).to be_checked
    expect(page.find('#employment_past')).to be_checked
    expect(page.find('#employment_future')).to be_checked
    expect(page.find('#billable_true')).to be_checked
    expect(page.find('#billable_false')).to be_checked
  end

  it "has all the filters off." do
    visit experience_path

    uncheck "Current"
    uncheck "Past"
    uncheck "Future"
    uncheck "Billable"
    uncheck "Support"
    click_submit

    expect(page.find('#employment_current')).to be_checked
    expect(page.find('#employment_past')).not_to be_checked
    expect(page.find('#employment_future')).not_to be_checked
    expect(page.find('#billable_true')).not_to be_checked
    expect(page.find('#billable_false')).not_to be_checked
  end
end

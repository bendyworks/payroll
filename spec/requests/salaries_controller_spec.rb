require 'rails_helper'

describe "Salaries" do
  before :each do
    sign_in_admin
  end
  
  it "has a salary chart." do
    visit salaries_path

    expect(page).to have_css "#salaries_chart"
  end

  it "has all the filters on." do
    visit salaries_path

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
    visit salaries_path

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

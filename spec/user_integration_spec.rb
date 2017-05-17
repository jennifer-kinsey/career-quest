require "spec_helper"

describe("new user path", {:type => :feature}) do
  it("successfully creates new user and signs in") do
    visit("/")
    click_link("Sign Up")
    fill_in("user-name", with: "Jesus")
    fill_in("user-email", with: "christ@god.com")
    fill_in("user-password", with: "123456")
    fill_in("user-password-confirmation", with: "123456")
    click_button("Sign Up")
    expect(page).to have_content("Welcome, Jesus")
  end
end

describe("logout path", {:type => :feature}) do
  it("successfully creates new company") do
    login
    click_link("Logout")
    expect(page).not_to have_content("Companies")
    expect(page).to have_content("Start your Quest")
  end
end

describe("companies path", {:type => :feature}) do
  it("successfully creates new company") do
    login
    visit("/users/home")
    click_link("Companies")
    fill_in("company_name", with: "Guardian")
    click_button("Add Company")
    expect(page).to have_content("Guardian")
  end
  it("successfully updates company") do
    login
    Company.create({name: "Guardian"})
    visit("/users/companies")
    click_link("Guardian")
    click_link("Edit Company Info")
    fill_in("company_name", with: "Fancy Guardian")
    click_button("Update Company Information")
    expect(page).to have_content("Fancy Guardian")
  end
  it("successfully deletes company") do
    login
    visit("/users/home")
    click_link("Companies")
    fill_in("company_name", with: "Guardian")
    click_button("Add Company")
    expect(page).to have_content("Guardian")
  end
end

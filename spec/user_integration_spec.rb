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
  let(:current_user) { UserDetail.find_by(name: "Jesus") }

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
    current_user.companies.create({name: "Guardian"})
    visit("/users/companies")
    click_link("Guardian")
    click_link("Edit Company Info")
    fill_in("company_name", with: "Fancy Guardian")
    click_button("Update Company Information")
    expect(page).to have_content("Fancy Guardian")
  end
  it("successfully deletes company") do
    login
    current_user.companies.create({name: "Guardian"})
    visit("/users/home")
    click_link("Companies")
    click_link("Guardian")
    click_link("Edit Company Info")
    click_button("Delete Company")
    expect(page).not_to have_content("Guardian")
  end
end

# describe("contacts path", {:type => :feature}) do
#   let(:current_user) { UserDetail.find({name: "Jesus"}) }
  
#   it("successfully creates new contact") do
#     login
#     visit("/users/home")
#     click_link("Companies")
#     fill_in("company_name", with: "Guardian")
#     click_button("Add Company")
#     expect(page).to have_content("Guardian")
#   end
#   it("successfully updates contact") do
#     login
#     current_user.companies.create({name: "Guardian"})
#     visit("/users/companies")
#     click_link("Guardian")
#     click_link("Edit Company Info")
#     fill_in("company_name", with: "Fancy Guardian")
#     click_button("Update Company Information")
#     expect(page).to have_content("Fancy Guardian")
#   end
#   it("successfully deletes contact") do
#     login
#     current_user.companies.create({name: "Guardian"})
#     visit("/users/home")
#     click_link("Companies")
#     click_link("Edit Company")
#     click_button("Delete Company")
#     expect(page).not_to have_content("Guardian")
#   end
# end

# describe("positions path", {:type => :feature}) do
#   let(:current_user) { UserDetail.find({name: "Jesus"}) }
  
#   it("successfully creates new position") do
#     login
#     visit("/users/home")
#     click_link("Companies")
#     fill_in("company_name", with: "Guardian")
#     click_button("Add Company")
#     expect(page).to have_content("Guardian")
#   end
#   it("successfully updates position") do
#     login
#     current_user.companies.create({name: "Guardian"})
#     visit("/users/companies")
#     click_link("Guardian")
#     click_link("Edit Company Info")
#     fill_in("company_name", with: "Fancy Guardian")
#     click_button("Update Company Information")
#     expect(page).to have_content("Fancy Guardian")
#   end
#   it("successfully deletes position") do
#     login
#     current_user.companies.create({name: "Guardian"})
#     visit("/users/home")
#     click_link("Companies")
#     click_link("Edit Company")
#     click_button("Delete Company")
#     expect(page).not_to have_content("Guardian")
#   end
# end

# describe("correspondence path", {:type => :feature}) do
#   let(:current_user) { UserDetail.find({name: "Jesus"}) }
  
#   it("successfully creates new correspondence") do
#     login
#     visit("/users/home")
#     click_link("Companies")
#     fill_in("company_name", with: "Guardian")
#     click_button("Add Company")
#     expect(page).to have_content("Guardian")
#   end
#   it("displays correspondence on company page") do
#     login
#     visit("/users/home")
#     click_link("Companies")
#     fill_in("company_name", with: "Guardian")
#     click_button("Add Company")
#     expect(page).to have_content("Guardian")
#   end
#   it("displays correspondence on positions page") do
#     login
#     visit("/users/home")
#     click_link("Companies")
#     fill_in("company_name", with: "Guardian")
#     click_button("Add Company")
#     expect(page).to have_content("Guardian")
#   end
#   it("displays correspondence on contacts page") do
#     login
#     visit("/users/home")
#     click_link("Companies")
#     fill_in("company_name", with: "Guardian")
#     click_button("Add Company")
#     expect(page).to have_content("Guardian")
#   end
#   it("successfully updates correspondence") do
#     login
#     current_user.companies.create({name: "Guardian"})
#     visit("/users/companies")
#     click_link("Guardian")
#     click_link("Edit Company Info")
#     fill_in("company_name", with: "Fancy Guardian")
#     click_button("Update Company Information")
#     expect(page).to have_content("Fancy Guardian")
#   end
#   it("successfully deletes correspondence") do
#     login
#     current_user.companies.create({name: "Guardian"})
#     visit("/users/home")
#     click_link("Companies")
#     click_link("Edit Company")
#     click_button("Delete Company")
#     expect(page).not_to have_content("Guardian")
#   end
# end
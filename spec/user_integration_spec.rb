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
    click_link("Add a new company")
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

describe("contacts path", {:type => :feature}) do
  let(:current_user) { UserDetail.find_by(name: "Jesus") }

  it("successfully creates new contact") do
    login
    visit("/users/home")
    click_link("Contacts")
    click_link("Add a Contact")
    fill_in("contact-name", with: "Frank Gaffey")
    click_button("Add Contact")
    expect(page).to have_content("Frank Gaffey")
  end
  it("successfully updates contact") do
    login
    current_user.contacts.create({name: "Frank Gaffey"})
    visit("/contacts")
    click_link("Frank Gaffey")
    click_link("Edit Contact")
    fill_in("contact-name", with: "Not Frank Gaffey")
    click_button("Edit Contact")
    expect(page).to have_content("Not Frank Gaffey")
  end
  it("successfully deletes contact") do
    login
    current_user.contacts.create({name: "Frank Gaffey"})
    visit("/contacts")
    click_link("Frank Gaffey")
    click_link("Edit Contact")
    click_button("Delete Contact")
    expect(page).not_to have_content("Frank Gaffey")
  end
end

describe("positions path", {:type => :feature}) do
  let(:current_user) { UserDetail.find_by(name: "Jesus") }

  it("successfully creates new position") do
    login
    visit("/users/home")
    click_link("Positions")
    click_link("Add a Position")
    fill_in("job_title", with: "Keeper of the Gate")
    click_button("Proceed to Company Info")
    fill_in("company_name", with: "The Guardians")
    click_button("Add Application")
    expect(page).to have_content("The Guardians")
    expect(page).to have_content("Keeper of the Gate")
  end
  it("successfully updates position") do
    login
    company = current_user.companies.create({name: "Fancy Guardian"})
    current_user.positions.create({title: "Keeper of the Gate", company_id: company.id})
    visit("/users/positions")
    click_link("Keeper of the Gate")
    click_link("Update Position Info")
    fill_in("job_title", with: "Not Fancy Guardian")
    click_button("Edit Position")
    expect(page).to have_content("Not Fancy Guardian")
  end
  it("successfully deletes position") do
    login
    company = current_user.companies.create({name: "Fancy Guardian"})
    position = current_user.positions.create({title: "Keeper of the Gate", company_id: company.id})
    visit("/position/#{position.id}/edit")
    click_button("Delete This Position")
    expect(page).not_to have_content("Fancy Guardian")
    expect(page).not_to have_content("Keeper of the Gate")
  end
end

describe("correspondence path", {:type => :feature}) do
  let(:current_user) { UserDetail.find_by(name: "Jesus") }
  let(:contact) { current_user.contacts.create({name: "Frank Gaffey"}) }
  let(:company) { current_user.companies.create({name: "Fancy Guardian"}) }
  let(:position) { current_user.positions.create({title: "Keeper of the Gate", company_id: company.id}) }
  let(:correspondence) { current_user.correspondences.create({action: "Sent Resume"}) }

  it("successfully creates new correspondence") do
    login
    visit("/users/home")
    click_link("Correspondences")
    click_link("Add Correspondence")
    fill_in("action", with: "Sent Resume")
    click_button("Add Correspondence")
    expect(page).to have_content("Sent Resume")
  end
  it("edits the correspondence") do
    login
    correspondence
    company
    visit("/users/correspondences")
    click_link("Sent Resume")
    click_link("Update Correspondence")
    page.select("#{company.name}", from: "company-id")
    click_button("Edit Correspondence")
    expect(page).to have_content("Company: Fancy Guardian")
  end
  it("displays correspondence on company page") do
    login
    correspondence.update({company_id: company.id})
    visit("/users/companies")
    click_link("Fancy Guardian")
    expect(page).to have_content("Action: Sent Resume")
  end
  it("displays correspondence on positions page") do
    login
    correspondence.update({position_id: position.id})
    visit("/users/positions")
    click_link("Keeper of the Gate")
    expect(page).to have_content("Action: Sent Resume")
  end
  it("displays correspondence on contacts page") do
    login
    correspondence.update({contact_id: contact.id})
    visit("/contacts")
    click_link("Frank Gaffey")
    expect(page).to have_content("Action: Sent Resume")
  end
  it("successfully deletes correspondence") do
    login
    correspondence
    visit("/users/correspondences")
    click_link("Sent Resume")
    click_link("Update Correspondence")
    click_button("Delete Correspondence")
    expect(page).not_to have_content("Sent Resume")
  end
end

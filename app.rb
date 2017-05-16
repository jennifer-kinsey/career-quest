require "bundler/setup"
Bundler.require :default
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

use Rack::Session::Cookie, :secret => '877de719-65d4-4f40-83bf-3b83d56d40db'

helpers do
  def logged_in?
    !session[:user].empty?
  end

  def current_user
    UserDetail.find_by(user_credential_id: session[:user])
  end
end

get "/" do
  erb :index
end

get "/sessions/login" do
  erb :"/sessions/login"
end

get "/sessions/logout" do
  session[:user].clear
  redirect "/"
end

get "/users/home" do
  @user = current_user
  @companies = Company.all
  erb :"/users/home"
end

get "/registrations/signup" do
  erb :"/registrations/signup"
end

post "/registrations" do
  @user = UserCredential.create({
    email: params["user-email"],
    password: params["user-password"],
    password_confirmation: params["user-password-confirmation"],
    name: params["user-name"]
  })
  userdeets = UserDetail.create({user_credential_id: @user.id, name: params["user-name"]})
  @user.update({user_detail_id: userdeets.id})
  if @user.errors.any?
    erb :error
  else
    session[:user] = @user.id
    redirect "/users/home"
  end
end

post "/sessions" do
  @user = UserCredential.find_by(email: params["user-email"]).try(:authenticate, params["user-password"])
  if @user
    session[:user] = @user.id
    redirect "/users/home"
  else
    erb :error
  end
end

get "/users/new_position" do
  @user = current_user
  erb :add_new_position
end

post '/users/add_new_position' do
  @user = current_user
  @new_position = Position.create({
    title: params['job_title'],
    application_status: "incomplete",
    description: params['description'],
    est_salary: params['est_salary'],
    url: params['url'],
    notes: params['notes'],
    user_detail_id: @user.id,
  })
  @companies = Company.all
  if @new_position.save
    erb :add_new_company
  else
    erb :error
  end
end

get '/users/add_company' do
  @user = current_user
  @new_position = Position.find(params['id'])
  erb :add_new_company
end

patch '/users/add_existing_company' do
  @user = current_user
  company = Company.find(params['company-id'])
  position = Position.find(params['position-id'])
  position.update({company_id: company.id})

  # we want to push
  @user.companies.push(company)
  if position.update({company_id: company.id})
    redirect "/users/home"
  else
    erb :error
  end
end

post '/users/add_new_company' do
  @user = current_user
  @new_company = Company.create({
    name: params['company_name'],
    location: params['location'],
    website: params['website'],
    services: params['services'],
    size: params['size'],
    specializations: params['specializations'],
    pros: params['pros'],
    cons: params['cons'],
    notes: params['notes'],
    user_detail_id: current_user.id,
  })
  @user.companies.push(@new_company)
  position = Position.find(params['position-id'])
  position.update({company_id: @new_company.id })
  if @new_company.save
    redirect "/users/home"
  else
    erb :error
  end
end

get '/users/companies' do
  @user = current_user
  erb :"/companies/companies"
end

post "/users/new_company_companies_page" do
  @user = current_user
  @new_company = Company.create({
    name: params['company_name'],
    location: params['location'],
    website: params['website'],
    services: params['services'],
    size: params['size'],
    specializations: params['specializations'],
    pros: params['pros'],
    cons: params['cons'],
    notes: params['notes'],
    user_detail_id: current_user.id,
  })
 # we want to push
  @user.companies.push(@new_company)
  if @new_company.save
    redirect "/users/companies"
  else
    erb :error
  end
end

get "/contacts" do
  @contacts = Contact.all
  erb :"contacts/contacts"
end

get "/contacts/add" do
  @companies = current_user.companies
  erb :"contacts/add_contact"
end

post "/contacts" do
  Contact.create({
    name: params["contact-name"],
    job_title: params["contact-title"],
    phone: params["contact-phone"],
    email: params["contact-email"],
    linkedin: params["contact-linkedin"],
    notes: params["contact-notes"],
    user_detail_id: current_user.id,
    company_id: params["company-id"]
  })
  redirect "/contacts"
end

get "/contact/:id" do
  @contact = Contact.find(params["id"])
  erb :"/contacts/contact"
end

get "/contacts/edit/:id" do
  @contact = Contact.find(params["id"])
  @companies = current_user.companies
  redirect :"/contact/edit_contact"
end

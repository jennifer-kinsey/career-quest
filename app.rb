require "bundler/setup"
require 'twitter'
Bundler.require :default
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

use Rack::Session::Cookie, :secret => '877de719-65d4-4f40-83bf-3b83d56d40db'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "MoUVWybJPWTR94gPIGgI21mfo"
  config.consumer_secret     = "NdpPVsv4yHXSkSADY496XYOvnw7Zp64sqR1oVHLQc0g70q2ye3"
  config.access_token        = "1947890120-y6zKs5RDWLcwgXsUZgoPsldE2pCP0HF4TWLtUJK"
  config.access_token_secret = "81CTF9SAj7ILPdn4Eh3prT58ka0DiXeEzkF44t6noNU7v"
end

helpers do
  def logged_in?
    return false if session[:user].nil?
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
  if @user
    @companies = @user.companies
    @not_applied_positions = @user.positions.where(:application_status => "Not Applied")+ @user.positions.where(:application_status => "")
    erb :"/users/home"
  else
    erb :error
  end
end

get "/users/home/pending_response" do
  @user = current_user
  if @user
    @companies = @user.companies
    @pending_response_positions = @user.positions.where(:application_status => "Applied, Pending Response")
    erb :"/users/home_pending_response"
  else
    erb :error
  end
end

get "/users/home/in_progress" do
  @user = current_user
  if @user
    @companies = @user.companies
    @in_progress_positions = @user.positions.where(:application_status => "Applied, In Progress")
    erb :"/users/home_in_progress"
  else
    erb :error
  end
end

get "/users/home/received_offer" do
  @user = current_user
  if @user
    @companies = @user.companies
    @received_offer_positions = @user.positions.where(:application_status => "Received Offer")
    erb :"/users/home_received_offer"
  else
    erb :error
  end
end

get "/users/home/archived" do
  @user = current_user
  if @user
    @companies = @user.companies
    @archived_positions = @user.positions.where(:application_status => "Archived")
    erb :"/users/home_archived"
  else
    erb :error
  end
end

get "/registrations/signup" do
  erb :"/registrations/signup"
end

patch "/registrations" do
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
  erb :"/positions/add_new_position"
end

post '/users/add_new_position' do
  @user = current_user
  @new_position = Position.create({
    title: params['job_title'],
    application_status: params['application_status'],
    description: params['description'],
    est_salary: params['est_salary'],
    url: params['url'],
    notes: params['notes'],
    user_detail_id: @user.id,
    qualifications: params["qualifications"]
  })
  @companies = @user.companies
  if @new_position.save
    erb :"/companies/add_new_company"
  else
    erb :error
  end
end

get '/users/add_company' do
  @user = current_user
  @new_position = Position.find(params['id'])
  erb :"/companies/add_new_company"
end

patch '/users/add_existing_company' do
  @user = current_user
  company = Company.find(params['company-id'])
  position = Position.find(params['position-id'])
  position.update({company_id: company.id})
  company.positions.push(position)
  if position.update({company_id: company.id})
    redirect "/users/positions"
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
  @new_company.positions.push(position)
  if @new_company.save
    redirect "/users/positions"
  else
    erb :error
  end
end

get '/users/companies' do
  @user = current_user
  if !@user
    erb :error
  else
    @companies = @user.companies
    erb :"/companies/companies"
  end
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

get '/company/:id' do
  @company = Company.find(params['id'])
  @positions = @company.positions
  erb :"/companies/company"
end

get '/company/:id/edit' do
  @company = Company.find(params['id'])
  erb :"/companies/company_edit"
end

patch '/company/:id/edit' do
  @company = Company.find(params['id'])
  @company.update({
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
  # binding.pry
  redirect "/company/#{@company.id}"
end

delete '/company/:id/delete' do
  company = Company.find(params['id'])
  company.destroy
  redirect '/users/companies'
end

get '/users/positions' do

  if logged_in?
    @positions = current_user.positions
    erb :"positions/positions"
  else
    erb :error
  end
end

get '/position/by_qualification' do
  if logged_in?
    @positions = current_user.positions.sort_by{|position| position.qualifications}
    erb :"positions/positions"
  else
    erb :error
  end
end

get '/position/by_company' do
  if logged_in?
    @positions = current_user.positions.sort_by{|position| position.company.name}
    erb :"positions/positions"
  else
    erb :error
  end
end

get '/position/by_title' do
  if logged_in?
    @positions = current_user.positions.sort_by{|position| position.title}
    erb :"positions/positions"
  else
    erb :error
  end
end

get '/position/by_status' do
  if logged_in?
    @positions = current_user.positions.sort_by{|position| position.application_status}
    erb :"positions/positions"
  else
    erb :error
  end
end

get '/position/:id' do
  @position = Position.find(params['id'])
  erb :"/positions/position"
end

get '/position/:id/edit' do
  @position = Position.find(params['id'])
  erb :"/positions/position_edit"
end

patch '/position/:id/edit' do
  @position = Position.find(params['id'])
  @position.update({
    title: params['job_title'],
    application_status: params["application_status"],
    description: params['description'],
    offer: params['offer'],
    schedule: params['schedule'],
    url: params['url'],
    est_salary: params['est_salary'],
    notes: params['notes'],
    resume: params['resume'],
    cover_letter: params['cover_letter']
  })
  redirect "/position/#{@position.id}"
end

delete '/position/:id/delete' do
  position = Position.find(params['id'])
  position.destroy
  redirect "/users/positions"
end

get "/contacts" do
  if current_user
    @contacts = current_user.contacts
    erb :"contacts/contacts"
  else
    erb :error
  end
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
  @count = 0
  erb :"/contacts/contact"
end

post '/tweets' do
  @contact = Contact.find(params['contact-id'])
  @count = params['count'].to_i
  @user = params['user']
  tweets = client.user_timeline(@user, count: @count)
  sweetweets = Hash.new
  tweets.each {|tweet| sweetweets.store(tweet.full_text, tweet.retweet_count) }
  sweetweets.each {|t, r| @contact.tweets.create({tweet: t, retweet: r, handle: @user})}
  redirect "/contact/#{@contact.id}"
end

delete '/tweet/:id/delete' do
  @contact = Contact.find(params['contact-id'])
  tweet = @contact.tweets.find(params['id'].to_i)
  tweet.delete
  redirect "/contact/#{@contact.id}"
end

delete '/clear_tweets' do
  @contact = Contact.find(params['contact-id'])
  tweets = @contact.tweets
  tweets.each {|t| t.delete }
  redirect "/contact/#{@contact.id}"
end

get "/contacts/edit/:id" do
  @contact = Contact.find(params["id"])
  @companies = current_user.companies
  erb :"/contacts/edit_contact"
end

patch "/contacts" do
  contact = Contact.find(params["contact-id"])
  contact.update({
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

delete "/contacts/delete/:id" do
  contact = Contact.find(params["id"])
  contact.delete
  redirect "/contacts"
end


get '/users/correspondences' do
  @user = current_user
  @correspondences = @user.correspondences
  if @user
    @correspondences = @user.correspondences
    erb :"correspondences/correspondences"
  else
    erb :error
  end
end

get '/correspondence/new' do
  @user = current_user
  @companies = @user.companies
  @positions = @user.positions
  @contacts = @user.contacts
  erb :"correspondences/add_correspondence"
end

post '/correspondence/new' do
  current_user.correspondences.create({
    action: params['action'],
    mode: params['mode'],
    date: params['date'],
    notes: params['notes'],
    contact_id: params['contact-id'],
    position_id: params['position-id'],
    company_id: params['company-id']
    })
  redirect '/users/correspondences'
end

get '/correspondence/:id' do
  @correspondence = Correspondence.find(params['id'])
  erb :"correspondences/correspondence"
end

get '/correspondence/:id/edit' do
  @companies = current_user.companies
  @positions = current_user.positions
  @contacts = current_user.contacts
  @correspondence = Correspondence.find(params['id'])
  erb :"correspondences/correspondence_edit"
end

patch '/correspondence/:id/edit' do
  Correspondence.find(params['id']).update({
    action: params['action'],
    mode: params['mode'],
    date: params['date'],
    notes: params['notes'],
    contact_id: params['contact-id'],
    position_id: params['position-id'],
    company_id: params['company-id']
    })
  redirect "correspondence/#{params['id']}"
end

delete '/correspondence/:id/delete' do
  Correspondence.find(params['id']).delete
  redirect '/users/correspondences'
end

# Settings Routes
get "/users/settings" do
  @user = current_user
  erb :"/users/settings"
end

get "/users/settings/edit" do
  @user = current_user
  erb :"/users/settings_edit"
end

patch "/users/settings/edit" do
  @user = current_user
  @user.update({
    career_objectives: params["career_objectives"],
    webpage: params["webpage"],
    resume_template: params["resume_template"],
    cover_letter_template: params["cover_letter_template"],
    skills: params["skills"],
    name: params["user-name"]
  })
  @user.user_credential.update({
    name: params["user-name"],
    email: params["user-email"],
    password: params["user-password"],
    password_confirmation: params["user-password-confirmation"]
  })
  redirect "/users/settings"
end

delete "/users/settings/delete" do
  current_user.user_credential.destroy
  current_user.destroy
  redirect '/'
end

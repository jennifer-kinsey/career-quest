require "bundler/setup"
Bundler.require :default
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

use Rack::Session::Cookie, :secret => '877de719-65d4-4f40-83bf-3b83d56d40db'

helpers do
  def logged_in?
    !session[:user].empty?
  end

  def current_user
    UserCredential.find_by(id: session[:user])
  end
end

get "/" do
  @user = UserDetail.create({name: "Grady"})
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
  erb :"/users/home"
end

get "/registrations/signup" do
  erb :"/registrations/signup"
end

post "/registrations" do
  @user = UserCredential.create({
    email: params["user-email"],
    password: params["user-password"],
    name: params["user-name"],
  })
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


get '/profile/:id' do
  @user = UserDetail.find(params['id'])
  @companies = Company.all
  erb :profile_home
end

get "/profile/:id/new_position" do
  @user = UserDetail.find(params['id'])
  erb :add_new_position
end

post '/profile/:id/add_new_position' do
  @user = UserDetail.find(params['id'])
  @new_position = Position.create({title: params['job_title'],
                                   application_status: "incomplete",
                                   description: params['description'],
                                   est_salary: params['est_salary'],
                                   url: params['url'],
                                   notes: params['notes'],
                                   user_detail_id: @user.id})
  if @new_position.save
    erb :add_new_company
  else
    erb :error
  end
end

get '/profile/:id/add_company' do
  @user = UserDetail.find(params['id'])
  @new_position = Position.find(params['id'])
  @companies = Company.all
  erb :add_new_company
end

patch '/profile/:id/add_existing_company' do
  @user = UserDetail.find(params['id'])
  company = Company.find(params['company-id'])
  position = Position.find(params['position-id'])
  position.update({company_id: company.id})
  if position.update({company_id: company.id})
    redirect "/profile/#{@user.id}"
  else
    erb :error
  end
end

post '/profile/:id/add_new_company' do
  @user = UserDetail.find(params['id'])
  @new_company = Company.create({name: params['company_name'],
                                 location: params['location'],
                                 website: params['website'],
                                 services: params['services'],
                                 size: params['size'],
                                 specializations: params['specializations'],
                                 pros: params['pros'],
                                 cons: params['cons'],
                                 notes: params['notes']})
  position = Position.find(params['position-id'])
  position.update({company_id: @new_company.id })
  if @new_company.save
    redirect "/profile/#{@user.id}"
  else
    erb :error
  end
end

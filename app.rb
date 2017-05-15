require "bundler/setup"
Bundler.require :default
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

use Rack::Session::Cookie, :secret => '877de719-65d4-4f40-83bf-3b83d56d40db'

get "/" do
  erb :index
end

get "/sessions/login" do
  erb :"/sessions/login"
end

get "/users/home" do
  @user = UserCredential.find(session[:user])
  erb :"/users/home"
end

get "/registrations/signup" do
  erb :"/registrations/signup"
end

post "/registrations" do
  @user = UserCredential.create({email: params["user-email"], password: params["user-password"]})
  if @user.errors.any?
    erb :"/error"
  else
    session[:user] = @user.id
    redirect "/users/home"
  end
end

post "/sessions" do
  @user = UserCredential.find_by(email: params["user-email"], password: params["user-password"])
  if @user.errors.any?
    erb :"/error"
  else
    session[:user] = @user.id
    redirect "/users/home"
  end
end

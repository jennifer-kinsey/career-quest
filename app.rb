require "bundler/setup"
Bundler.require :default
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get "/" do
  erb :index
end

get "/sessions/login" do
  erb :"/sessions/login"
end

get "/registrations/signup" do
  erb :"/registrations/signup"
end

post "/registrations" do
  @user = UserCredential.create({email: params["user-email"], password: params["user-password"]})
  if @user.errors.any?
    erb :"/registrations/error"
  else
    sessions[:user] = @user.id
    redirect "/users/home"
  end
end

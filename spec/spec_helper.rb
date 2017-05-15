ENV["RACK_ENV"] = "test"

require "bundler/setup"
Bundler.require :default, :test
set :root, Dir.pwd

require "shoulda-matchers"
require "capybara/rspec"
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require "./app"

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.after(:each) do
    Company.all.each do |d|
      d.destroy
    end
    Position.all.each do |d|
      d.destroy
    end
    Contact.all.each do |d|
      d.destroy
    end
    Correspondence.all.each do |d|
      d.destroy
    end
    UserCredential.all.each do |d|
      d.destroy
    end
    UserDetail.all.each do |d|
      d.destroy
    end
  end
end

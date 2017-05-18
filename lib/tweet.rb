require 'twitter'
class Tweet < ActiveRecord::Base
  belongs_to :contact
end

require "spec_helper"

describe Contact do
  it { should have_many :user_details }
  it { should validate_presence_of :name }
end

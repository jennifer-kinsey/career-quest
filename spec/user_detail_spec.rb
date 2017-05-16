require "spec_helper"

describe UserDetail do
  it { should have_many :companies }
  it { should have_many :contacts }
  it { should belong_to :user_credential }

end

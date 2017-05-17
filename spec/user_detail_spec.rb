require "spec_helper"

describe UserDetail do
  it { should belong_to :user_credential}
  it { should have_many :positions }
  it { should have_many :correspondences }
  it { should have_many :companies }
  it { should have_many :contacts }

end

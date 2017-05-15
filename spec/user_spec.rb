require "spec_helper"

describe Company do
  it { should have_many :user_details }
end

describe Contact do
  it { should have_many :user_details }
end

describe Correspondence do
  it { should belong_to :user_detail }
  it { should belong_to :contact }
end

describe Position do
  it { should belong_to :user_detail }
  it { should belong_to :company }
end

describe UserCredential do
  it { should belong_to :user_detail }
  it { should_not allow_value("").for(:name) }
  it { should_not allow_value("   ").for(:name) }
  it { should_not allow_value("").for(:email) }
  it { should_not allow_value("   ").for(:email) }
  it { should validate_uniqueness_of :email }
  it { should_not allow_value("").for(:password) }
  it { should_not allow_value("   ").for(:password) }

end

describe UserDetail do
  it { should have_many :companies }
  it { should have_many :contacts }
  it { should belong_to :user_credential }
end

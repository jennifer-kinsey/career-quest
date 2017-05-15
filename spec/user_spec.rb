require "spec_helper"

describe Company do
  it { should have_many :user_details }
  it { should validate_presence_of :name }
end

describe Contact do
  it { should have_many :user_details }
  it { should validate_presence_of :name }
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
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
end

describe UserDetail do
  it { should have_many :companies }
  it { should have_many :contacts }
  it { should belong_to :user_credential }
  it { should validate_presence_of :name }
end

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
end

describe UserDetail do
  it { should have_many :companies }
  it { should have_many :contacts }
  it { should belong_to :user_credential }
end

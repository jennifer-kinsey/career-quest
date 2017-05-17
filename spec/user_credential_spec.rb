require "spec_helper"

describe UserCredential do
  it { should belong_to :user_detail }
  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should validate_presence_of :password_digest }
  it { should have_secure_password }
end

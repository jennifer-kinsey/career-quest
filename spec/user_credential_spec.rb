require "spec_helper"

describe UserCredential do
  it { should belong_to :user_detail }

  it { should validate_presence_of :name }
  it { should_not allow_value("").for(:name) }
  it { should_not allow_value("   ").for(:name) }

  it { should validate_presence_of :email }
  it { should_not allow_value("").for(:email) }
  it { should_not allow_value("   ").for(:email) }
  it { should validate_uniqueness_of :email }

  it { should_not allow_value("").for(:password_digest) }
  it { should_not allow_value("   ").for(:password_digest) }

end

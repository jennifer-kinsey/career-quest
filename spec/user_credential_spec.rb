require "spec_helper"

describe UserCredential do
  it { should belong_to :user_detail }
  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should validate_presence_of :password_digest }
  it { should validate_length_of(:password_digest).is_at_least(6) }

  it { should have_secure_password }

  it 'should not accept an email address without an @ symbol' do
    test_email = 'email.com'
    user = UserCredential.create({name: 'testname', email: test_email, password: 'testpassword'})
    expect(user.save).to eq false
  end

  it 'should not accept an email address without an .' do
    test_email = 'email@email'
    user = UserCredential.create({name: 'testname', email: test_email, password: 'testpassword'})
    expect(user.save).to eq false
  end

  it 'should downcase an email' do
    test_email = 'Email@email.com'
    user = UserCredential.create({name: 'testname', email: test_email, password: 'testpassword'})
    expect(user.email).to eq 'email@email.com'
  end
end

module  UserHelper

  def login
    visit("/")
    click_link("Sign Up")
    fill_in("user-name", with: "Jesus")
    fill_in("user-email", with: "christ@god.com")
    fill_in("user-password", with: "123456")
    fill_in("user-password-confirmation", with: "123456")
    click_button("Sign Up")

  end

  def logout
    visit ("/")
    click_link 'Log Out'
  end



end

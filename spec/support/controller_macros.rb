module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = User.new(email: "a@b.c", password: "1", password_confirmation: "1")
      user.save(validate: false)
      sign_in user
    end
  end
end
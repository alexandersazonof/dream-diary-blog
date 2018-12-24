class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.from_facebook(request.env['omniauth.auth'].inspect)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.facebook'] = request.env['omniauth.auth'].inspect
      redirect_to new user_registration_url
    end
  end
end

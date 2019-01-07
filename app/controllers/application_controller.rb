class ApplicationController < ActionController::Base

  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:username, :email, :password, :password_confirmation)
    end
  end

  private

    def user_not_authorized
      flash[:warning] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
end

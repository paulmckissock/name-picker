class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(resource)
    wheels_path
  end

  protected

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_user_registration_path, alert: "You need to sign in or sign up before continuing."
    end
  end
end

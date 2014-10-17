class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?   

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:avatar, :name, :birthday, :gender, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:avatar, :email, :name, :birthday, :gender, :password, :password_confirmation, :current_password) }
  end
end
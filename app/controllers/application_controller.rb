require "application_responder"

class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?
  self.responder = ApplicationResponder
  respond_to :html

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def user_not_authorized
    flash[:alert] = 'Forbidden.'
    redirect_to(request.referrer || root_path)
  end

  def record_not_found
    flash[:alert] = 'Not found.'
    redirect_to action: :index
  end
end

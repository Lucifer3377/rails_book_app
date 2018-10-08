class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  ActionController::Parameters.permit_all_parameters = true

  include Pundit
  after_action :verify_authorized, unless: :devise_controller?

  # rescue_from CanCan::AccessDenied do |exception|
  #   respond_to do |format|
  #     format.json { head :forbidden }
  #     format.html { redirect_to main_app.root_url, :alert => exception.message }
  #   end
  # end
end

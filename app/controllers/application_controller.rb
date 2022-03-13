class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_user_location!, if: :storable_location?

  # def checknames
  #   if current_user.first_name.blank? || current_user.last_name.blank?
  #     redirect_to "/account-settings"
  #   end
  # end
  

  protected
  
  def configure_permitted_parameters
    added_attrs = [:email, :first_name, :last_name, :username, :bio, :password, :avatar, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username, :password, :password_confirmation, :remember_me])
    devise_parameter_sanitizer.permit :sign_in, keys: [:email, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  # def after_sign_in_path_for(resource)
  #   # return the path based on resource
  #   unless current_user.first_name.blank? || current_user.last_name.blank?
  #     '/account-settings'
  #   else

  #   end
  # end
end

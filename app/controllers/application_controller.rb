class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    '/admin'
  end

  def after_sign_out_path_for(resource)
    # TODO make this configurable
    'https://auth-test.berkeley.edu/cas/logout'
  end

  def check_authenticated
    if current_person.present?
      Rails.logger.info "Current admin uid = #{current_person.uid}"
    else
      redirect_to person_omniauth_authorize_path :cas
    end
  end
end

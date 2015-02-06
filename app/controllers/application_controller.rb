class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/denied'
  end

  def current_user
    current_person
  end

  def after_sign_in_path_for(resource)
    '/admin'
  end

  def after_sign_out_path_for(resource)
    Rails.application.secrets['cas_logout_url']
  end

  def check_authenticated
    if current_person.present?
      Rails.logger.info "Current admin uid = #{current_person.calnet_uid}"
    else
      redirect_to person_omniauth_authorize_path :cas
    end
  end

end

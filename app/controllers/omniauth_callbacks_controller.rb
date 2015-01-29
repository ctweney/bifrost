class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def cas
    Rails.logger.debug "Omniauth data: #{request.env['omniauth.auth'].inspect}"
    uid = request.env['omniauth.auth'].uid
    admin = Person.from_omniauth(request.env['omniauth.auth'])
    if admin.present?
      Rails.logger.warn "Admin session begins for UID #{uid}"
      sign_in_and_redirect admin
    else
      Rails.logger.warn "Access Denied: UID #{uid} does not exist in Admins table"
      redirect_to '/denied'
    end
  end

end

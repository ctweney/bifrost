class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def cas
    uid = request.env['omniauth.auth.uid']
    Rails.logger.info "User from CAS: #{uid}"
    admin = Admin.from_omniauth(request.env['omniauth.auth'])
    if admin.present?
      Rails.logger.warn "Admin session begins for UID #{uid}"
      sign_in_and_redirect admin
    else
      Rails.logger.warn "Access Denied: UID #{uid} does not exist in Admins table"
      redirect_to '/denied'
    end
  end
end

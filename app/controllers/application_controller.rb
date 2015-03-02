class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_filter :check_ip

  after_filter :log_access

  rescue_from CanCan::AccessDenied do
    redirect_to '/denied'
  end

  def current_user
    current_person
  end

  def after_sign_in_path_for(resource)
    '/admin'
  end

  def after_sign_out_path_for(resource)
    url = "#{Rails.application.secrets['cas_logout_url']}?service=#{request.protocol}#{request.host_with_port}"
    Rails.logger.warn "Logout url = #{url}"
    url
  end

  def check_authenticated
    if current_person.present?
      Rails.logger.info "Current admin uid = #{current_person.calnet_uid}"
    else
      redirect_to person_omniauth_authorize_path :cas
    end
  end

  def check_ip
    valid = false
    whitelist.each do |addr|
      if addr.matches? remote
        valid = true
        break
      end
    end
    unless valid
      Rails.logger.warn "Received a request from remote IP that is not on IP whitelist: #{remote}"
      render :nothing => true, :status => 403
    end
  end

  def whitelist
    Rails.cache.fetch('ip_whitelist', expires_in: 24.hours) do
      whitelist = []
      Rails.application.secrets['ip_whitelist'].each do |addr|
        whitelist << NetAddr::CIDR.create(addr)
      end
      whitelist
    end
  end

  def log_access
    line = "ACCESS_LOG #{remote} #{request.request_method} #{request.filtered_path} #{status}"
    if current_person.present?
      line += " uid=#{current_person.calnet_uid}"
    else
      line += " uid=NONE"
    end
    line += " class=#{self.class.name} action=#{params["action"]} view=#{view_runtime}ms db=#{db_runtime}ms"
    Rails.logger.warn line
  end

  def remote
    # HTTP_X_FORWARDED_FOR is the client's IP when we're behind Apache; REMOTE_ADDR otherwise
    request.env['HTTP_X_FORWARDED_FOR'] || request.env['REMOTE_ADDR']
  end

end

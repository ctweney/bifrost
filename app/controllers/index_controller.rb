class IndexController < ApplicationController

  before_filter :check_authenticated, except: [:denied, :health_check]

  def index
    redirect_to '/admin'
  end

  def denied
  end

  def health_check
    begin
      system_roles = Role.where(role_id: [Ability::ADMIN_ROLE_ID, Ability::EDITOR_ROLE_ID])
    rescue StandardError => exception
      Rails.logger.error "Got an exception trying to connect to database for health check: #{exception}"
    end

    if system_roles.present? && system_roles.size == 2
      render :nothing => true, :status => 200
    else
      Rails.logger.fatal 'System health check failed! Database is unreachable or system roles are not present.'
      render :nothing => true, :status => 500
    end
  end
end

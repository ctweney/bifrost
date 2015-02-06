class ApiController < ApplicationController

  def apps
    authorize! :read, nil
    @apps = Application.all
  end

end

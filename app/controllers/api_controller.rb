class ApiController < ApplicationController

  def apps
    authorize! :view, nil
    @apps = Application.all
  end

end

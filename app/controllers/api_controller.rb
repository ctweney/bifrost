class ApiController < ApplicationController

  def apps
    @apps = Application.all
  end

end

class IndexController < ApplicationController

  before_filter :check_authenticated, except: [:denied]

  def index
    redirect_to '/admin'
  end

  def denied
  end
end



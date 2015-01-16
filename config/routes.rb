Rails.application.routes.draw do
  get 'index/index'
  devise_for :admins, :controllers => {:omniauth_callbacks => 'omniauth_callbacks'}
  devise_scope :admin do
    get '/logout', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/denied' => 'index#denied', :defaults => {:format => 'html'}
  get '/' => 'index#index', :defaults => {:format => 'html'}
end

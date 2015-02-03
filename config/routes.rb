Rails.application.routes.draw do
  get 'index/index'
  devise_for :people, :controllers => {:omniauth_callbacks => 'omniauth_callbacks'}
  devise_scope :person do
    get '/logout', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/api/apps' => 'api#apps'
  get '/denied' => 'index#denied', :defaults => {:format => 'html'}
  get '/' => 'index#index', :defaults => {:format => 'html'}
end

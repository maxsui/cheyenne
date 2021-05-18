Rails.application.routes.draw do
  default_url_options :host => "lepiedaletrier.herokuapp.com"
  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  resources :customers
  resources :groups
  resources :goal_categories
  resources :goals
  resources :observables
  resources :observable_categories
  resources :projects do
    put 'toogle_observable'
    resources :seances, controller: 'nested_seances'
  end
  resources :seances do
    put 'confirm', on: :member
    resources :seance_customers do
      put 'note', on: :member
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'dashboard#show'
end

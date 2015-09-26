Rails.application.routes.draw do
  get '/home', to: "static_pages#home", as: 'home'
  get '/about', to: "static_pages#about", as: 'about'
  get '/contact', to: "static_pages#contact", as: 'contact'
  get '/current', to: "terms#current", as: 'current'
  get '/upcoming', to: "terms#upcoming", as: 'upcoming'
  get '/quickstart_parents', to: "static_pages#quickstart_parents", as: 'quickstart_parents'
  get '/quickstart_instructors', to: "static_pages#quickstart_instructors", as: 'quickstart_instructors'
  get '/register', to: "static_pages#register", as: 'register'
  root 'static_pages#home'

  resources :contact_forms, :only => [:create]

  resources :buildings do
    resources :rooms, only: [:new]
  end
  resources :rooms, :except => [:index,:show,:new]
  
  resources :terms do
    resources :sections, only: [:new]
  end
  get 'terms/:id/schedule/:day', :to => 'terms#schedule', :as => 'term_schedule'
  resources :sections, :except => [:new]
  
  devise_for :users
  get '/account', to: 'users#show', as: 'account'
  resources :users, only: [:edit,:update]
  get 'instructors/', to: 'instructors#index', as: 'instructors'
  get 'users/', to: 'users#index', as: 'users'
  resources :students, except: :show
  resources :enrollments, except: :show do
    post 'mark_paid'
  end
  get 'agreements', to: 'agreements#index', as: 'agreements'
  get 'agreements/:kind', to: 'agreements#show', as: 'agreement'
  post 'agreements/:kind', to: 'agreements#submit'
  post 'agreements/:kind/reset_all', to: 'agreements#reset_all', as: 'reset_all_agreements'
  
  resources :responsibilities, except: :show

  resources :events

  resources :subjects
  resources :courses

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

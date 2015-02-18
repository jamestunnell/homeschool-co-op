Rails.application.routes.draw do
  get '/home', to: "static_pages#home", as: 'home'
  get '/about', to: "static_pages#about", as: 'about'
  get '/contact', to: "static_pages#contact", as: 'contact'
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
  resources :sections, :except => [:index,:new]
  
  devise_for :users
  get '/account', to: 'users#show', as: 'account'
  resources :users, only: [:edit,:update]
  get 'instructors/', to: 'instructors#index', as: 'instructors'
  resources :students, except: :show
  resources :enrollments, except: :show do
    post 'mark_paid'
  end
  
  resources :responsibilities, except: :show
  get '/responsibilities/:kind', to: "responsibilities#kind", as: "responsibility_kind"
  
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

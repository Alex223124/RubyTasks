Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks",
                                       registrations: 'user/registrations' }

  scope '(:locale)', locale: /en|ru/  do
    post 'search', to: 'search#search'
    get 'tags/:tag', to: 'tasks#tasks_by_tag', as: :tag

    delete 'comments/:id', to: 'comments#destroy'

    resources :categories

    get 'for_perform', to: 'tasks#tasks_for_perform'
    resources :tasks do
      resources :comments
      member do
        put 'estimation_confirmed', to: 'tasks#estimation_confirmed'
        put 'estimation_rejected', to: 'tasks#estimation_rejected'
        put 'finished', to: 'tasks#task_finished'
        put 'estimation_added', to: 'tasks#estimation_added'
        put 'add_mark', to: 'tasks#add_mark'
        put 'suspend', to: 'tasks#task_suspended'
        put 'continued', to: 'tasks#task_continued'
        put 'add_extra_time', to: 'tasks#add_extra_time'
        put 'agree_with_extra_time', to: 'tasks#agree_with_extra_time'
        put 'disagree_with_extra_time', to: 'tasks#disagree_with_extra_time'
      end
    end

    resources :users do
      resources :comments
      member do
        post 'add', to: 'users#add'
        get 'family', to: 'users#family'
      end
    end

  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'users#index'

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

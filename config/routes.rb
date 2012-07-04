Toolbox::Application.routes.draw do
  
  resources :categories
  match 'categories/:year/:month' => 'categories#index'
  match 'categories/new/:year/:month' => 'categories#new'
  match 'categories/:id/:year/:month' => 'categories#show'
  match 'categories/:id/edit/:year/:month' => 'categories#edit'

  resources :transactions
  match 'transactions/reconcile/:id' => 'transactions#reconcile'
  match 'transactions/unreconcile/:id' => 'transactions#unreconcile'
  match 'transactions/:year/:month' => 'transactions#index'
  match 'transactions/new/:year/:month' => 'transactions#new'
  match 'transactions/:id/edit/:year/:month' => 'transactions#edit'

  match 'savings_accounts/add_subtract_form/:id' => 'savings_accounts#add_subtract_form'
  match 'savings_accounts/add_subtract' => 'savings_accounts#add_subtract'
  resources :savings_accounts

  match 'list_items/complete/:id' => 'list_items#complete'
  match 'list_items/incomplete/:id' => 'list_items#incomplete'
  match 'list_items/quick_add' => 'list_items#quick_add'
  resources :list_items
  resources :lists

  match 'inventory_items/increase_quantity' => 'inventory_items#increase_quantity'
  match 'inventory_items/decrease_quantity' => 'inventory_items#decrease_quantity'
  resources :inventory_items
  resources :inventories

  match 'login' => 'auth#login'
  match 'logout' => 'auth#logout'
  match 'authorize' => 'auth#authorize'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

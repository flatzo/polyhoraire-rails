Web::Application.routes.draw do

  namespace :polyhoraire do
    root :action => :index
    post 'connect'
    get 'trimesters'
    namespace :export do
      root :action => :index
      namespace :google do
        get 'oauth2callback'
        get 'calendars'
        match 'export/:trimester' => '#export'
        get 'export'
        match 'pushto/:calendarID' => '#pushto'
        get 'pushto'
        
        
        
        root :action => :index
      end
    end
  end
=begin
  match ':controller/:action/:id'
  get 'polyhoraire/export/google/oauth2callback'

  
  get "polyhoraire/trimesters"
  
  match "polyhoraire/export/trimester/:id" => 'polyhoraire/export#trimester'
  
  get "polyhoraire/export/google/calendars"
  get "polyhoraire/export/google/oauth2callback"
  get 'polyhoraire/export/google'
  match 'polyhoraire/export/google/export/:id' => 'polyhoraire/export/google#export'
  match 'polyhoraire/export/google/send/:id' => 'polyhoraire/export/google#send'

=end 
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

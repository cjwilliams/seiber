ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action
  
  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)
  map.login  '/login',  :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.admin '/dashboard', :controller => 'sessions', :action => 'dashboard'

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products
  map.resources :sessions
  map.resources :users
  
  map.resources :properties, :has_many => :photos, :active_scaffold => :true
  map.resources :photos, :belongs_to => :property, :active_scaffold => :true
  map.resources :pages, :active_scaffold => :true
  
  map.rental_properties 'public/properties/rental', :controller => 'properties', :action => 'rental'
  map.sale_properties 'public/properties/sale', :controller => 'properties', :action => 'sale'
  map.public_property 'public/properties/:id', :controller => 'properties', :action => 'public'
  map.public_photo 'public/photos/:id', :controller => 'photos', :action => 'public'
  
  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "properties"

  # See how all your routes lay out with "rake routes"

  map.connect '/:title', :controller => 'pages', :action => 'show', :title => 'title'
  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
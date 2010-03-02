class PropertiesController < ApplicationController
  include GeoKit::Geocoders

  uses_tiny_mce

  skip_before_filter :login_required, :only => [:index, :public, :rental, :sale]
  layout "admin", :except => [:index, :public, :rental, :sale]

  active_scaffold :property do |config|
    config.label = "Properties"
    
    config.sti_children = [:rental, :sale]
    config.sti_create_links = :true

    config.columns.exclude :lat, :lng
    
    config.list.columns = [:address, :available_date, :type, :availability,
                            :number_beds, :number_baths,
                            :monthly_rent, :deposit] 
    
    config.columns[:yard].form_ui = :checkbox
    config.columns[:laundry].form_ui = :checkbox
    config.columns[:garage].form_ui = :checkbox
    config.columns[:availability].form_ui = :select
    config.columns[:full_description].form_ui = :text_editor
    
    
    config.columns[:number_beds].label = "Bedrooms"
    config.columns[:number_baths].label = "Bathrooms"
    
    config.nested.add_link("Photos", [:photos])
    
    config.create.columns.add_subgroup "Address" do |address_group|
      address_group.add :street_address, :unit_number, :city, :state, :zip_code
    end
    
    config.update.columns.add_subgroup "Address" do |address_group|
      address_group.add :street_address, :unit_number, :city, :state, :zip_code
    end
    
    config.create.columns.add_subgroup "Rental Data" do |rental_group|
      rental_group.add :monthly_rent, :deposit
    end
    
    config.update.columns.add_subgroup "Rental Data" do |rental_group|
      rental_group.add :monthly_rent, :deposit
    end
    
    config.create.columns.add_subgroup "Sale Data" do |sale_group|
      sale_group.add :mls_number, :listing_price
    end
    
    config.update.columns.add_subgroup "Sale Data" do |sale_group|
      sale_group.add :mls_number, :listing_price
    end
    
    config.create.columns.add_subgroup "Description" do |description_group|
      description_group.add :full_description, :number_beds, :number_baths, :square_feet
    end
    
    config.update.columns.add_subgroup "Description" do |description_group|
      description_group.add :full_description, :number_beds, :number_baths, :square_feet
    end
    
    config.create.columns.add_subgroup "Property Features" do |features_group|
      features_group.add :yard, :laundry, :garage
    end
    
    config.update.columns.add_subgroup "Property Features" do |features_group|
      features_group.add :yard, :laundry, :garage
    end
  end

  def index
    @properties = Property.find(:all, :conditions => {:availability => "Available"})
    @map_center = MultiGeocoder.geocode('Davis, CA')
    render :layout => "application"
  end
  
  def public
    @property = Property.find(params[:id])
    @map_center = MultiGeocoder.geocode(@property.address)
    @photos = Photo.find(:all, :conditions => {:property_id => @property})
    @properties = @property       # QuickFix for Google Mapping -- Fix This!!
    render :layout => "application"
  end
  
  def rental
    @rentals = Rental.find(:all, :conditions => {:availability => "Available"}, :order => "street_address ASC, unit_number ASC")
    render :layout => "application"
  end
  
  def sale
    @sales = Sale.find(:all, :conditions => {:availability => "Available"}, :order => "street_address ASC, unit_number ASC")
    render :layout => "application"
  end
end

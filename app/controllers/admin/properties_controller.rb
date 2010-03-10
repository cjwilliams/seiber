class Admin::PropertiesController < ApplicationController
  include GeoKit::Geocoders
  uses_tiny_mce

  layout "admin"
  before_filter :login_required
  
  active_scaffold do |config|
    config.label = "Properties"
    
    config.sti_children = [:rental, :sale]
    config.sti_create_links = :true

    config.columns.exclude :lat, :lng
    config.actions.exclude :show
    
    config.list.columns = [:type, :address, :availability,
                            :number_beds, :number_baths,
                            :monthly_rent, :deposit, :listing_price] 
    config.list.sorting = {:type => :asc, :street_address => :asc}
    
    config.nested.add_link("Photos", [:photos])

    config.columns[:yard].form_ui = :checkbox
    config.columns[:laundry].form_ui = :checkbox
    config.columns[:garage].form_ui = :checkbox
#    config.columns[:covered_parking].form_ui = :checkbox
#    config.columns[:laundry_hookup].form_ui = :checkbox
#    config.columns[:hvac].form_ui = :checkbox
#    config.columns[:deck].form_ui = :checkbox
#    config.columns[:bus].form_ui = :checkbox

    config.columns[:availability].form_ui = :select
    config.columns[:full_description].form_ui = :text_editor
    
    
    config.columns[:number_beds].label = "Bedrooms"
#    config.columns[:number_beds].form_ui = :select
    config.columns[:number_baths].label = "Bathrooms"
#    config.columns[:number_baths].form_ui = :select
    
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
end

class PropertiesController < ApplicationController
  include GeoKit::Geocoders

  skip_before_filter :login_required
  
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

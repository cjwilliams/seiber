class Property < ActiveRecord::Base
  validates_presence_of :number_address, :street_address, :city, :state, :zip_code
  validates_numericality_of :number_address, :zip_code
  
  has_many :photos
  
  acts_as_mappable :auto_geocode => {:field => :address, :error_message => "Could not geocode address"}
  
  def address
    "#{self.number_address} #{self.street_address} ##{self.unit_number}, #{self.city}, #{self.state} #{self.zip_code}"
  end
  
  def address_line_1
    "#{self.number_address} #{self.street_address} ##{self.unit_number}"
  end
  
  def address_line_2
    "#{self.city}, #{self.state} #{self.zip_code}"
  end
  
  def rental?
    self.type == "Rental"
  end
  
  def sale?
    self.type == "Sale"
  end
  
  def no_photos?
    Photo.find(:all, :conditions => {:property_id => self.id}).empty?
  end
  
#  def map
#    @map = GMap.new("map")
#    @map.center_zoom_init([self.lat, self.lng], 14)
#  end
end

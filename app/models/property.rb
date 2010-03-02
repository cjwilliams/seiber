class Property < ActiveRecord::Base
  validates_presence_of :street_address, :city, :state, :zip_code
  validates_numericality_of :zip_code
  
  has_many :photos #, :emails
  
  acts_as_mappable :auto_geocode => {:field => :address, :error_message => "Could not geocode address"}
  
  def address
    "#{self.street_address}#{self.unit}, #{self.city}, #{self.state} #{self.zip_code}"
  end
  
  def address_line_1
    "#{self.street_address}#{self.unit}"
  end
  
  def address_line_2
    "#{self.city}, #{self.state} #{self.zip_code}"
  end
  
  def unit
    if self.unit_number.nil?
      return ""
    else
      return" ##{self.unit_number}"
    end
  end
  
  def rental?
    self.type == "Rental"
  end
  
  def sale?
    self.type == "Sale"
  end
  
  def name
    self.address.to_s
  end
  
  def no_photos?
    Photo.find(:all, :conditions => {:property_id => self.id}).empty?
  end
  
#  def map
#    @map = GMap.new("map")
#    @map.center_zoom_init([self.lat, self.lng], 14)
#  end
end

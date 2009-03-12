class Sale < Property
  validates_presence_of :listing_price
  validates_numericality_of :listing_price
end

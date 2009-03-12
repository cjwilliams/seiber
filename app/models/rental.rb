class Rental < Property
  validates_presence_of :monthly_rent, :deposit
  validates_numericality_of :monthly_rent, :deposit
end

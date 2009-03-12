class CreateProperties < ActiveRecord::Migration
  def self.up
    create_table :properties do |t|
      t.integer       :number_address
      t.string        :street_address
      t.integer       :unit_number
      t.string        :city
      t.string        :state
      t.integer       :zip_code
      
      t.datetime      :available_date
      t.integer       :lease_type_id
      t.string        :availability
      
      t.integer       :number_beds
      t.integer       :number_baths
      t.integer       :square_feet
      
      t.float         :lat
      t.float         :lng
      
      t.string        :type
 
      # Rental Properties      
      t.float         :monthly_rent
      t.float         :deposit
      
      # Sale Properties
      t.float         :listing_price
      t.integer       :mls_number
      
      t.text          :full_description
      
      t.boolean       :laundry
      t.boolean       :yard
      t.boolean       :garage

      t.timestamps
    end
  end

  def self.down
    drop_table :properties
  end
end

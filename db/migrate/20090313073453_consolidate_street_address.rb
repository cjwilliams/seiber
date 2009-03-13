class ConsolidateStreetAddress < ActiveRecord::Migration
  def self.up
    change_column   :properties,  :unit_number,   :string
    remove_column   :properties,  :number_address
  end

  def self.down
    change_column   :properties,  :unit_number,       :integer
    add_column      :properties,  :number_address,    :integer
  end
end

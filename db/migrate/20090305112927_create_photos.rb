class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.integer       :property_id
      t.string        :caption
      t.string        :type
      
      t.string        :item_file_name
      t.string        :item_content_type
      t.integer       :item_file_size
      
      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end

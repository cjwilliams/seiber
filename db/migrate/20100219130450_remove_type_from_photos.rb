class RemoveTypeFromPhotos < ActiveRecord::Migration
  def self.up
    remove_column   :photos,    :type
  end

  def self.down
    add_column      :photos,    :type,    :string
  end
end

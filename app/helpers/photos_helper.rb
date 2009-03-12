module PhotosHelper
  def item_form_column(record, input_name)
    file_field :record, :item
  end

  def item_column(photo)
    image_tag photo.item.url(:thumb)
  end
  
  def property_id_form_column(record, address)
    select(:record, :property_id, :address => address, :id => id)
  end
end

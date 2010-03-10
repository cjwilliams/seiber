module PhotosHelper
  def item_form_column(record, input_name)
    file_field :record, :item
  end

  def item_column(record)
    image_tag record.item.url(:thumb)
  end
  
  def property_id_form_column(record, input_name)
    select(:record, :property_id, Property.all.collect{|p| [p.name, p.id]}, {:include_blank => 'Select One'})
  end  
  
  def property_id_column(record)
    if record.property_id.blank?
      ""
    else
      h(Property.find(record.property_id).name)
    end
  end
end

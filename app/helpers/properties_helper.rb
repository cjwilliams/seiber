module PropertiesHelper
  def available_date_form_column(record, name)
    date_select(:record, :available_date, :name => name, :order => [:month, :day, :year],
                :start_year => Time.now.year)
  end
  
  def availability_form_column(record, name)
    select(:record, :availability, ["Available", "Not Available"], :name => name)
  end
  
  def type_form_column(record, name)
    select(:record, :type, ["Rental", "Sale"], :name => name)
  end
end

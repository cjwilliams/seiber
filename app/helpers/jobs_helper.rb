module JobsHelper
  def start_date_form_column(record, name)
    date_select(:record, :start_date, :name => name, :order => [:month, :day, :year],
                :start_year => Time.now.year)
  end
  
  def end_date_form_column(record, name)
    date_select(:record, :end_date, :name => name, :order => [:month, :day, :year],
                :start_year => Time.now.year)
  end
  
  def work_term_form_column(record, name)
    select(:record, :work_term, ["Part Time", "Summer", "Temporary"], :name => name)
  end
  
  def status_form_column(record, name)
    select(:record, :status, ["Open", "Filled"], :name => name)
  end
  
  def start_pay_form_column(record, name)
    select(:record, :start_pay, (8..20).to_a, :name => name)
  end
  
  def end_pay_form_column(record, name)
    select(:record, :end_pay, (8..20).to_a, :name => name)
  end
end

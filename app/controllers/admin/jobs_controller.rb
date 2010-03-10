class Admin::JobsController < ApplicationController
  layout "admin"
  before_filter :login_required
  
  active_scaffold :jobs do |config|
    config.list.columns = [:title, :status, :description, :skills,
                            :start_date, :end_date, :work_term,
                            :start_pay, :end_pay, :notes]
    
    config.columns[:status].form_ui = :select
    config.columns[:work_term].form_ui = :select
    config.columns[:start_pay].form_ui = :select
    config.columns[:end_pay].form_ui = :select
    config.columns[:work_term].label = "Employment Type"
    config.columns[:start_pay].label = "Starting Wage ($)"
    config.columns[:end_pay].label = "Ending Wage ($)"
    
    config.create.columns.add_subgroup "Important" do |important_group|
      important_group.add :title, :status, :start_pay, :end_pay
    end
    
    config.update.columns.add_subgroup "Important" do |important_group|
      important_group.add :title, :status, :start_pay, :end_pay
    end
    
    config.create.columns.add_subgroup "Dates" do |dates_group|
      dates_group.add :work_term, :start_date, :end_date
    end
    
    config.update.columns.add_subgroup "Dates" do |dates_group|
      dates_group.add :work_term, :start_date, :end_date
    end
    
    config.create.columns.add_subgroup "Description" do |description_group|
      description_group.add :description, :skills
    end
    
    config.update.columns.add_subgroup "Address" do |description_group|
      description_group.add :description, :skills
    end
    
    config.create.columns.add_subgroup "Other" do |other_group|
      other_group.add :notes
    end
    
    config.update.columns.add_subgroup "Other" do |other_group|
      other_group.add :notes
    end
  end
end

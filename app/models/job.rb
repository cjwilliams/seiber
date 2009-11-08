class Job < ActiveRecord::Base
  validates_presence_of :title, :description, :skills, :start_pay, :end_pay, :start_date, :work_term, :status
  validates_numericality_of :start_pay, :end_pay
end

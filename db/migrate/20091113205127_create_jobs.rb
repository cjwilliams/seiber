class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.string   :title
      t.text     :description
      t.text     :skills
      t.datetime :start_date
      t.datetime :end_date
      t.string   :work_term
      t.float    :start_pay
      t.float    :end_pay
      t.text     :notes
      t.string   :status
      
      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end


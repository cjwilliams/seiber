class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.string    :contact_name
      t.string    :phone_number
      t.string    :contact_email
      t.string    :subject
      t.string    :body
      t.string    :property_id
      t.boolean   :read,        :default => "false"
      t.boolean   :replied,     :default => "false"
      t.boolean   :sent

      t.timestamps
    end
  end

  def self.down
    drop_table :emails
  end
end

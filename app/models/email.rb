class Email < ActiveRecord::Base
  validates_presence_of :contact_name, :phone_number, :contact_email, :contact_email_confirmation
  validates_confirmation_of :contact_email
  
  belongs_to :property
  
  def read?
    self.read
  end
  
  def replied?
    self.replied
  end
end

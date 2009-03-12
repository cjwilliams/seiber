class Photo < ActiveRecord::Base
  require 'mime/types'
  
#  validates_attachment_presence :item
#  validates_attachment_content_type :item, :content_type => ['image']

  has_attached_file :item, :whiny_thumbnails => true,
      :styles => {:mini => "75x75#",
                  :thumb => "100x100#",
                  :public => "400x300"
                 }
                  
  belongs_to :property
end
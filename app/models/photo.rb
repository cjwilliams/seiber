# 3/2/2010 CJW - Added options :url and :path to configure persistent images between deployments

require 'mime/types'
require 'paperclip'

class Photo < ActiveRecord::Base
  has_attached_file :item, :whiny_thumbnails => true,
      :styles => {
        :mini => "75x75#",
        :thumb => "100x100#",
        :public => "400x300"
      },
      :url => "/system/:class/:id_:style.:extension",
      :path => ":rails_root/public/system/:class/:id_:style.:extension"
      
  validates_attachment_presence :item
  validates_attachment_content_type :item, :content_type => ['image/jpg', 'image/jpeg', 'image/gif', 'image/png']

  belongs_to :property
  
  def name
    "#{self.property.name} (#{self.caption})"
  end
end
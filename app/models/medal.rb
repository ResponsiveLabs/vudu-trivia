class Medal < ActiveRecord::Base
  attr_accessible :image, :title
  has_attached_file :image
end

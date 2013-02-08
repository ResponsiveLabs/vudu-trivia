class Medal < ActiveRecord::Base
  attr_accessible :image, :title

  mount_uploader :image, MedalUploader
  attr_accessible :image, :image_cache, :remove_image
end

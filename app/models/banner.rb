class Banner < ActiveRecord::Base
  attr_accessible :published

  mount_uploader :image, ImageUploader
  attr_accessible :image, :image_cache, :remove_image

  def self.availableBanner
    Banner.where(published: true).limit(1).first
  end

end


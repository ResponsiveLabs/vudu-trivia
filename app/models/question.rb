class Question < ActiveRecord::Base
  attr_accessible :answer_url, :explanation, :points_to_earn, :published, :started_at, :timer_in_seconds, :title

  has_many :assignments
  has_many :games, through: :assignments

  serialize :possible_answers, Array

  mount_uploader :image1, ImageUploader
  mount_uploader :image2, ImageUploader
  mount_uploader :image3, ImageUploader

  attr_accessible :image1, :image1_cache, :remove_image1
  attr_accessible :image2, :image2_cache, :remove_image2
  attr_accessible :image3, :image3_cache, :remove_image3
end

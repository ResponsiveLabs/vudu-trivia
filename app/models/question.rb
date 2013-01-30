class Question < ActiveRecord::Base
  attr_accessible :answer_url, 
      :explanation, 
      :points_to_earn, 
      :possible_answers, 
      :published, 
      :started_at, 
      :timer_in_seconds, 
      :title

  has_many :assignments
  has_many :games, through: :assignments

  attr_accessible :tag_list
  # Alias for acts_as_taggable_on :tags
  acts_as_taggable

  mount_uploader :image1, ImageUploader
  mount_uploader :image2, ImageUploader
  mount_uploader :image3, ImageUploader
  mount_uploader :title_cover, ImageUploader

  attr_accessible :image1, :image1_cache, :remove_image1
  attr_accessible :image2, :image2_cache, :remove_image2
  attr_accessible :image3, :image3_cache, :remove_image3
  attr_accessible :title_cover, :title_cover_cache, :remove_title_cover

  def answers
    possible_answers.split(',').map(&:strip)
  end

  def answered_right?(answer)
    answers.map(&:downcase).member? answer.downcase
  end

end

class User < ActiveRecord::Base
      has_many :points  
      has_many :badges , :through => :levels 
      has_many :levels  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :registerable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :facebook_id, :points

  has_many :games
  has_many :attempts
  has_many :questions, through: :attempts

  def self.initialize_from_facebook_graph(me)
    return nil if me.nil? || me['id'].blank?
    parameters = {
      email: "#{me['username']}@facebook.com",
      facebook_id: me['id'],
      password: me['id']
    }
    User.new(parameters)
  end

  def self.find_user_with_facebook_graph(graph)
    return nil if graph.nil? || graph['id'].blank?
    found_user = User.where(facebook_id: graph['id']).first
    found_user || User.initialize_from_facebook_graph(graph)
  end

  def rank
    # TODO: look for a better alternative
    User.all(:order => "points DESC").index(self) + 1
  end

  def self.top(number)
    User.all(:order => "points DESC", :conditions => 'facebook_id IS NOT NULL', :limit => number)
  end

  def watched_questions_ids
    unique_ids = []
    self.games.each do |game|
      current_ids = game.questions.collect { |question| question.id }
      unique_ids = unique_ids | current_ids
    end
    unique_ids
  end

  def save_question_in_history(question)
    Attempt.where(user_id: self.id, question_id: question.id).first_or_create
  end

  def question_ids_answered_right
    self.games.collect(&:answered_right).flatten.uniq
  end

  def questions_answered_right
    Question.find(:all, :conditions => ["id IN (?)", self.question_ids_answered_right])
  end

  def number_of_questions_answered_right_and_tagged_as(tag)
    questions = self.questions_answered_right
    questions.select { |q| q.tag_list.member? tag }.size
  end

end

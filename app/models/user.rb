class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :facebook_id, :points

  has_many :games

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

end

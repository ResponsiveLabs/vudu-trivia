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

  def rank
    # TODO: look for a better alternative
    User.all(:order => "points").index(self)
  end

end

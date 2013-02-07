class UsersController < ApplicationController
  before_filter :load_facebook_user

  def show
    @user = User.find_user_with_facebook_graph(@me)
    render 'show'
  end
end

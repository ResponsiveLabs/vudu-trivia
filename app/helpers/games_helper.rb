module GamesHelper

  # Returns a subset of @friends_using_app
  # If array is shorter than requested number of results,
  # then the remaining elements will be filled with placeholders
  def some_friends_using_app(amount)
    some_friends = @friends_using_app[0..amount]
    if some_friends.size < amount
      friend_stub = { 'pic_square' => 'http://placehold.it/50x50' }
      (amount - some_friends.size).times.each { some_friends << friend_stub }
    end
    some_friends
  end

end

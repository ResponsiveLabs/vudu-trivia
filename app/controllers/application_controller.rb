class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Koala::Facebook::OAuthTokenRequestError, :with => :handle_oauth_error
  rescue_from Koala::Facebook::AuthenticationError, :with => :handle_oauth_error

  # Helpers

  def host
    request.env['HTTP_HOST']
  end

  def scheme
    request.scheme
  end

  def url_no_scheme(path = '')
    "//#{host}#{path}"
  end

  def url(path = '')
    "#{scheme}://#{host}#{path}"
  end

  # Allows for direct oauth authentication

  FACEBOOK_SCOPE = 'user_likes,user_photos'

  def authenticator
    @authenticator ||= Koala::Facebook::OAuth.new(url('/auth/facebook/callback'))
  end

  def facebook_auth
    session[:access_token] = nil
    puts "\n\n"
    puts "facebook_auth"
    puts "\n\n"
    redirect_to authenticator.url_for_oauth_code(:permissions => FACEBOOK_SCOPE)
  end

  def facebook_auth_callback
    session[:access_token] = authenticator.get_access_token(params[:code])
    puts "\n\n"
    puts "facebook_auth_callback"
    puts "\n\n"
    if ENV['RACK_ENV'] == 'production'
      # Go back to the facebook canvas
      redirect_to ENV['FACEBOOK_APP_HOST']
    else
      redirect_to root_path
    end
  end

  def handle_oauth_error(error)
    puts "\n\n"
    puts "handle_oauth_error"
    puts "error = #{error}"
    puts "\n\n"
=begin
type: OAuthException, code: 190, error_subcode: 458, message: Error validating access token: User 506232400 has not authorized application 322243531223568.
type: OAuthException, code: 100, message: Invalid verification code format. [HTTP 400]
=end

    flash[:error] = t('games.welcome.oauth_error')
    if ENV['RACK_ENV'] == 'production'
      render "games/welcome"
    else
      render "games/welcome"
    end
  end

  # Allows for javascript authentication

  def access_token_from_cookie
    puts "\n\n"
    puts "access_token_from_cookie"
    puts "\n\n"
    user_info = authenticator.get_user_info_from_cookies(request.cookies)
    user_info['access_token'] if user_info
  end

  def access_token
    session[:access_token] || access_token_from_cookie
  end

  # Load user

  def load_facebook_user
    @graph = Koala::Facebook::API.new(access_token)

    if access_token
      @me = @graph.get_object("me")
      @friends = @graph.get_connections('me', 'friends')
      @friends_using_app = @graph.fql_query("SELECT uid, name, is_app_user, pic_square FROM user WHERE uid in (SELECT uid2 FROM friend WHERE uid1 = me()) AND is_app_user = 1")
    end

    @friends_using_app ||= []
  end

end

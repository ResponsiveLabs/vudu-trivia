class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Koala::Facebook::OAuthTokenRequestError, :with => :handle_oauth_error

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
    redirect_to authenticator.url_for_oauth_code(:permissions => FACEBOOK_SCOPE)
  end

  def facebook_auth_callback
    session[:access_token] = authenticator.get_access_token(params[:code])
    redirect_to root_path
  end

  def handle_oauth_error(error)
    facebook_auth
  end

  # Allows for javascript authentication

  def access_token_from_cookie
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
      @user = @graph.get_object("me")
      @friends = @graph.get_connections('me', 'friends')
      @friends_using_app = @graph.fql_query("SELECT uid, name, is_app_user, pic_square FROM user WHERE uid in (SELECT uid2 FROM friend WHERE uid1 = me()) AND is_app_user = 1")
    end
  end

end

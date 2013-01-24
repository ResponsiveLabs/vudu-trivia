class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Koala::Facebook::APIError, :with => :handle_facebook_auth_errors

  def authenticator
    @authenticator ||= Koala::Facebook::OAuth.new
  end

  # Cookie discovery

  def access_token_from_cookie
    user_info = authenticator.get_user_info_from_cookies(request.cookies)
    user_info['access_token'] if user_info
  end

  def access_token
    session[:access_token] ||= access_token_from_cookie
  end

  # Load user

  def load_facebook_user
    @graph = Koala::Facebook::API.new(access_token)

    if access_token
      flash[:error] = nil
      @me = @graph.get_object("me")
      @friends = @graph.get_connections('me', 'friends')
      @friends_using_app = @graph.fql_query("SELECT uid, name, is_app_user, pic_square FROM user WHERE uid in (SELECT uid2 FROM friend WHERE uid1 = me()) AND is_app_user = 1")
    end

    @friends_using_app ||= []
  end

  # OAuth handler

  # type: OAuthException, code: 100, message: This authorization code has expired.
  def handle_facebook_auth_errors(exception)
    session[:access_token] = nil
    flash[:error] = case exception.fb_error_code
                    when 100
                      t('facebook.errors.expired')
                    when 190
                      t('facebook.errors.invalid')
                    else
                      "Error (#{exception.fb_error_code}): #{exception.fb_error_message}"
                    end
    render 'games/welcome'
  end

end

class OauthController < ApplicationController

  def connect_instagram
    redirect_to Instagram.authorize_url(redirect_uri: instagram_callback_url)
  end

  def instagram
    response = Instagram.get_access_token(params[:code], redirect_uri: instagram_callback_url)
    render text: response.access_token
  end

end

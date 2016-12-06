class LoginController < ApplicationController
  
  def index
    @user  = get_current_user
    if user_signed_in?
      redirect_to url_for(:controller=>'program',:action => 'index')
    end
  end
end
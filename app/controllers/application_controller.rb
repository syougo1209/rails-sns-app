class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper
  

  def auth_login
    unless login?
    flash[:danger]="ログインしてください"
    redirect_to login_path
  end
end

def limit_action_from_other_user
 
  unless current_user?
  flash[:danger]="権限がありません"
  redirect_to root_path
  end
end

end

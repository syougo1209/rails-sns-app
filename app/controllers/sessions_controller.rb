class SessionsController < ApplicationController
  def new
  end
  
  def create
  user=User.find_by(name: params[:session][:name])
  if user && user.authenticate(params[:session][:password]) 
    login user
  flash[:success]="ログイン成功"
  redirect_to  root_path
  else
    flash.now[:danger]="名前またはパスワードが違います"
    render 'new'
  end
  end
  
  def destroy
  logout
  redirect_to login_path
  end
end

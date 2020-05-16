class UsersController < ApplicationController
    before_action :auth_login, only: [:edit, :update, :destroy,:following,:followers]
    before_action :limit_action_from_other_user, only: [:edit, :update, :destroy]
    
    def index
       @users=User.paginate(page: params[:page])
                  .search(params[:search],params[:prefecture])
    end
    
  def new
    @user=User.new
  end
  
 def create
   @user=User.new(user_params)
   if @user.save
       login @user
     flash[:success]="アカウント登録完了です"
     redirect_to @user
   else
     render "new"
   end
 end
  
  def show
    @user=User.find(params[:id])
    @posts=@user.posts.order(created_at: :desc).paginate(page: params[:page])
    @likeposts=@user.like_posts_feed.paginate(page: params[:page])
  end
  
  def edit
     @user=User.find(params[:id]) 
  end
  
  def update
      @user=User.find(params[:id])
      if @user.update_attributes(user_params)
          flash[:success]="編集が成功しました"
          redirect_to @user
     else
         render "edit"
     end
  end
  
  def destroy
     User.find(params[:id]).destroy
     flash[:success] = "ご利用ありがとうございました"
     redirect_to login_path
  end
  
  def following
      user=User.find(params[:id])
      @following=user.following.paginate(page: params[:page])
  end
  
  def followers
      user=User.find(params[:id])
      @followers=user.followers.paginate(page: params[:page])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :prefecture, :picture)
  end
  
end

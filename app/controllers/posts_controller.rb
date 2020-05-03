class PostsController < ApplicationController
    before_action :auth_login
    before_action :correct_user, only: [:edit,:update]

def new
   @post=current_user.posts.build
end

def create
    @post=current_user.posts.build(post_params)
    if @post.save
      flash[:success]="投稿が成功しました"
      redirect_to @post
    else
        render 'new'
    end
end

def show
@post=Post.find(params[:id])
end

def edit
   @post=Post.find_by(id: params[:id]) 
end

def update
     @post=Post.find_by(id: params[:id]) 
    if @post.update_attributes(post_params)
        flash[:success]="編集が成功しました"
        redirect_to @post
    else
        render 'edit'
    end
end

def destroy
    post=Post.find(params[:id])
    post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to root_path
end

private 

def post_params
    params.require(:post).permit(:content)
end

def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
  end


end

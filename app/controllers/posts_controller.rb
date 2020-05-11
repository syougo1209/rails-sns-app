class PostsController < ApplicationController
    before_action :auth_login
    before_action :correct_user, only: [:edit,:update, :destroy]
    
    
def index
    
    @posts=Post.order(created_at: :desc)
               .paginate(page: params[:page])
               .search(params[:search],params[:prefecture])
end

def new
   @post=current_user.posts.build
end

def create
    @post=current_user.posts.build(post_params)
    
    if @post.save
      flash[:success]="投稿が成功しました"
      @post.update(created_date: @post.created_at.to_s(:datetime_jp))
      redirect_to @post
    else
        render 'new'
    end
end

def show
@post=Post.find(params[:id])
@comments=@post.comments.paginate(page: params[:page])
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

def ranking
    @month=params[:search]
    @prefecture=params[:prefecture]
    @month_array=[["すべての月"]]
    (1..12).each do |i|
        @month_array << ["#{i}月"]
    end
    @posts=Post.ranking(@month,@prefecture)
end

private 

def post_params
    params.require(:post).permit(:content,:title,:picture,:latitude,:longitude,:address)
end

def correct_user
 @post = current_user.posts.find_by(id: params[:id])
  if @post.nil?
      flash[:danger]="権限がありません"
      redirect_to root_url 
  end
      
  end

end

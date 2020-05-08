class CommentsController < ApplicationController
    before_action :auth_login
    before_action :correct_user, only: [:destroy]
    
    def create
        @post=Post.find(params[:comment][:post_id])
        comment=current_user.comments.build(comment_params)
        if comment.save
            flash[:success]="コメントの追加に成功"

           redirect_to @post
        else
        @comments=@post.comments.paginate(page: params[:page])
        flash.now[:danger]="コメントが短すぎる、もしくは長すぎます"
         render 'posts/show'
    end
end
    
    def destroy
     
      post=Comment.find(params[:id]).post
      Comment.find(params[:id]).destroy
      flash[:success] = "コメントの削除に成功しました"
      redirect_to post
    end
    
    private
    
    def comment_params
    params.require(:comment).permit(:content,:post_id)
    end
    
    def correct_user
        user=Comment.find(params[:id]).user
        post=Comment.find(params[:id]).post
        if current_user != user
        flash[:danger]="権限がありません"
        redirect_to post 
        end
    end
end

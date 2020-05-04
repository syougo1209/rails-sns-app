class LikesController < ApplicationController
    before_action :auth_login
    
    def create
       @post = Post.find(params[:post_id])
     
    current_user.favorite(@post)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end

    end
    
    
    def destroy
        @post = Like.find(params[:id]).post
    current_user.unfavorite(@post)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end

end

end

class TagsController < ApplicationController
    before_action :auth_login
    before_action :correct_user, only: [:destroy]
   def create
      @tag=current_user.tags.build(tag_params)
      if @tag.save
          flash[:success]="ジャンルが追加されました"
          redirect_to root_path
      else
          flash[:danger]="設定しているものと同じジャンルは追加できません"
          redirect_to root_path
      end
   end
   
   def destroy
       tag=Tag.find(params[:id])
       tag.destroy
       flash[:success]="ジャンルが削除されました"
       redirect_to root_path
   end
   
   def show
       @tag=Tag.find(params[:id])
       @posts=Post.tag_post(@tag.tag_name).paginate(page: params[:page])
   end
  
   private
   
   def tag_params
    params.require(:tag).permit(:tag_name)
   end
   
   def correct_user
       tag=Tag.find(params[:id])
       user=User.find(tag.user_id)
       unless current_user==user
           flash[:danger]="権限がありません"
           redirect_to root_url 
       end
   end
end

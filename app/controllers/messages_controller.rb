class MessagesController < ApplicationController
     before_action :auth_login
     
    def create
        @message=current_user.messages.build(message_params)
        room=Room.find(@message.room_id)
        if @message.save
         flash[:success]="送信が成功しました"
         redirect_to room_path(room)
        else
         render 'rooms/show'
        end
    end
    
     private
   
   def message_params
       params.require(:message).permit(:content,:room_id)
   end
end

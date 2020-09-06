class RoomsController < ApplicationController
     before_action :auth_login
     
    def index
        @rooms=current_user.rooms.paginate(page: params[:page])
    end

   def show
    room=Room.find(params[:id]);
    @message=current_user.messages.build
    @messages=room.messages.last(20);
   end
   
end

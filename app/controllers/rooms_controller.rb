class RoomsController < ApplicationController
    
    def index
        @rooms=current_user.rooms.paginate(page: params[:page])
    end

   def show
    room=Room.find(params[:id]);
    @messages=room.messages.last(6);
   end
end

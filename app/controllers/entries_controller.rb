class EntriesController < ApplicationController
    
    def create
        user=User.find(params[:user_id])
        user_entries=Entry.where(user_id: user.id)
        current_user_entries=Entry.where(user_id: current_user.id)
        
        user_entries.each do |u_entry|
            current_user_entries.each do |c_entry|
                if u_entry.room_id==c_entry.room_id then
                    room=Room.find(u_entry.room_id)
                    redirect_to room and return
                end
            end
        end
         room=Room.new
                    if room.save
                        user.entries.create(room_id: room.id)
                        current_user.entries.create(room_id: room.id)
                        flash[:success]="部屋の作成に成功しました"
                        redirect_to room and return
                    else
                        flash[:danger]="部屋の作成に失敗しました"
                        render 'users/show'
                    end
    end #create
    
end

module UsersHelper
    def current_user?
    user=User.find(params[:id])
    if login? 
    current_user.id==user.id
    end
    end
end

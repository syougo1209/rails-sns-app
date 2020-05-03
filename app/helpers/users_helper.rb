module UsersHelper
    def current_user?
    user=User.find(params[:id])
    current_user.id==user.id
    end
end

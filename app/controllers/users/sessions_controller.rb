class Users::SessionsController < Devise::SessionsController

   def create
     super
     session[:user_id] = @user.id
   end

end

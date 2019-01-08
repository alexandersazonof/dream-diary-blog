class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]


  def edit
    if !current_user.is_admin
      redirect_to user_path
    end
    @user
  end

  def update
    respond_to do |format|
      if @user.update(post_params)
        @user.save
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    if !current_user.is_admin
      redirect_to user_path
    end

    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
  def set_user  
    @user = User.find(id)
  end

  def post_params
    params.require(:user).permit(:username, :email)
  end

  def id
    params[:id]
  end
end

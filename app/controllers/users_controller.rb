class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]


  def edit
    if (!current_user.is_admin?)
      if (current_user.id.to_i != id.to_i)
          redirect_to root_path
      end
    end

    @my_user = current_user
    @user
  end


  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit, notice: 'Have problem' }
      end
    end
  end

  def destroy
    authorize @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
  def set_user
    @user = User.find(id)
  end

  def user_params
    params.require(:user).permit(:username, :email, :icon)
  end

  def id
    params[:id]
  end


end

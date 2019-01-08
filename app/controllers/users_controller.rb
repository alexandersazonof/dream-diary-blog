class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]


  def edit
    authorize @user
  end

  def update
    authorize @user
    respond_to do |format|
      if @user.update(post_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
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

  def post_params
    params.require(:user).permit(:username, :email)
  end

  def id
    params[:id]
  end
end

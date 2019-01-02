class HomeController < ApplicationController

  ## Private only
  #
  # before_action :authenticate_user:, only: [:private]


  def index
    @feed_items = Post.all
  end

  def about
  end

  def show
    user_id = session[:user_id]
    @my_posts = Post.where( ["user_id = ?", user_id])
  end
end

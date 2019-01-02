class HomeController < ApplicationController

  ## Private only
  #
  # before_action :authenticate_user:, only: [:private]


  def index
    @feed_items = Post.all
  end

  def about
  end
end

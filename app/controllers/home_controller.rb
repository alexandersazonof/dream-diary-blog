class HomeController < ApplicationController
  def index
    @popular_tags = ActsAsTaggableOn::Tag.most_used(6)
    if params[:tag].present?
      @posts = Post.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
    else
      @posts = Post.paginate(:page => params[:page], :per_page => 5)
    end
  end

  def about
  end

  def show
    user_id = session[:user_id]
    @my_posts = Post.where( ["user_id = ?", user_id])
  end
end

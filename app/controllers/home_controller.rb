class HomeController < ApplicationController

  ## Private only
  #
  # before_action :authenticate_user:, only: [:private]


  def index
    @popular_tags = ActsAsTaggableOn::Tag.most_used(6)
    if params[:tag].present?
      @posts = Post.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
    elsif params[:sort].present?
      @posts = sort_params(params[:sort]).paginate(:page => params[:page], :per_page => 5)
    else
      @posts = Post.paginate(:page => params[:page], :per_page => 5)
    end
  end

  def about
  end

  def show
    @popular_tags = ActsAsTaggableOn::Tag.most_used(6)
    user_id = session[:user_id]
    @my_posts = Post.where( ["user_id = ?", user_id])
  end

  def search
    @popular_tags = ActsAsTaggableOn::Tag.most_used(6)

    if params[:search].blank?
      redirect_to(root_path, alert: "Empty field!") and return
    else
      @parameter = params[:search].downcase
      @results = Post.all.where("lower(name) LIKE :search", search: "%#{@parameter}%").paginate(:page => params[:page], :per_page => 5)
    end
  end

  private
  def sort_params(value)
    if value.eql? "author"
      @posts = Post.order('created_at ASC').reverse_order
    elsif value.eql? "date"
      @posts = Post.order('created_at ASC').reverse_order
    else
      @posts = Post.order('created_at ASC').reverse_order
    end
  end

end

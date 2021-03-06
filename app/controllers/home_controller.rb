class HomeController < ApplicationController

  helper_method :sort_direction

  def index
    @popular_tags = ActsAsTaggableOn::Tag.most_used(6)
    if params[:tag].present?
      @posts = Post.tagged_with(params[:tag]).paginate(:page => params[:page], per_page: 5)
    elsif params[:sort].present?
      @posts = sort_params(params[:sort]).paginate(:page => params[:page], per_page: 5)
    else
      @posts = Post.where(vision: true).paginate(:page => params[:page], per_page: 5)
    end
  end

  def about
  end

  def show
    @popular_tags = ActsAsTaggableOn::Tag.most_used(6)
    user_id = current_user.id
    @posts = current_user.posts.paginate(:page => params[:page], per_page: 5)
  end

  def search
    @popular_tags = ActsAsTaggableOn::Tag.most_used(6)

    if params[:search].blank?
      redirect_to(root_path, alert: "Empty field!") and return
    else
      @parameter = params[:search].downcase
      @posts = Post.all.where("lower(name) LIKE :search", search: "%#{@parameter}%").paginate(:page => params[:page], per_page: 5)
    end
  end

  def users
    if !current_user.is_admin?
      redirect_to root_path
    end
    @users = User.all.paginate(:page => params[:page], per_page: 10)
  end

  def mypost
    @popular_tags = ActsAsTaggableOn::Tag.most_used(6)
    id = params[:id].to_i
    @posts = User.find(id).posts.paginate(:page => params[:page], per_page: 5)
  end


  private
  def sort_params(value)
    if value == "author"
      @posts = Post.all.order('name ASC')
    elsif value == "date"
      @posts = Post.all.order('created_at DESC').reverse_order
    else
      @posts = Post.all.order('vision ASC')
    end
  end


end

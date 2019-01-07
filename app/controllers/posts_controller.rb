class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
    authorize @posts
  end

  def show
  end

  def new
    @post = Post.new
    authorize @post
  end

  def edit
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post.tag_list.add(@tags[:tag_list].split(","))
    @post.save
    @post.user_id = current_user.id
    number = rand(1000).to_s
    @post.url_mini = "https://picsum.photos/750/300/?image="+number
    @post.url = "https://picsum.photos/960/640/?image="+number
    @post.vision = @vision[:vision] == 'Public' ? true : false
    authorize @post


    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        @post.vision = @vision[:vision].to_s =='Public' ? true : false

        @post.tag_list = (@tags[:tag_list].split(","))
        @post.save
        @post.vision = @vision[:vision] == 'Public' ? true : false
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @post
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      @tags = params.require(:post).permit(:tag_list)
      @vision = params.require(:post).permit(:vision)
      params.require(:post).permit(:name, :content)
    end

end

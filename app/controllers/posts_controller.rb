class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    authorize @posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    authorize @post
  end

  # GET /posts/1/edit
  def edit
    authorize @post
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.tag_list.add(@tags[:tag_list].split(","))
    @post.save
    @post.user_id = session[:user_id]
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

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
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

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    authorize @post
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      @tags = params.require(:post).permit(:tag_list)
      @vision = params.require(:post).permit(:vision)
      params.require(:post).permit(:name, :content)
    end

end

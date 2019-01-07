class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user_id = current_user
    body = comment_params[:body]
    @comment = @post.comments.create(body: body, user_id: @user_id)
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
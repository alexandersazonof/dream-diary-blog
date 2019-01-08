class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user_id = current_user.id
    body = comment_params[:body]
    @comment = @post.comments.create(body: body, user_id: @user_id)
    @comment.save
    redirect_to post_path(@post)
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if !(current_user.present? && (current_user.id == @comment.user_id || current_user.is_admin?))
        redirect_to @post
      else
        @comment.destroy
        
        respond_to do |format|
            format.html { redirect_to @post }
            format.js
        end
    end
        
        
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end

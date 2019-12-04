class CommentsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_comment, only: [:create, :destroy]

  def create
    @comment = @post.comments.create(comment_params)
    if @comment.save
      redirect_to @post, notice: 'Dodano nowy komentarz.'
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.destroy
      redirect_to @post, notice: 'Komentarz został usunięty.'
    end
  end

  def set_comment
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:comment, :body)
  end
end

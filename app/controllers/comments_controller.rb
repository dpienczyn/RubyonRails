class CommentsController < ApplicationController
	skip_before_action :authenticate_user!

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		redirect_to post_path(@post), notice: 'Dodano nowy komentarz.'
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post), notice: 'Komentarz został usunięty.'
	end

	def comment_params
		params.require(:comment).permit(:comment, :body)
	end
end

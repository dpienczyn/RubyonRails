class Api::V1::PostsController < Api::ApplicationController
  #before_action :set_article, only: [:show, :update, :destroy]

  def index
    @posts = Post.where("title ILIKE ?", "#{params[:search]}%")
                 .page(params[:page]).per(9)
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      @subscribers = Subscriber.all
      @subscribers.all.each do |subscriber|
        SubscriberMailer.new_post(subscriber, @post).deliver
      end
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
  end

  private

  def set_post
    @post = current_user.posts.find_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(:author, :description, :title, :image)
  end
end

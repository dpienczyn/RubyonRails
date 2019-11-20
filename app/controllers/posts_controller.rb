class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.where("title ILIKE ?", "#{params[:search]}%")
    .page(params[:page]).per(9)
  end

  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = PostPdf.new(@post)
        send_data pdf.render, filename: "#{@post.title}.pdf",
        type: "application/pdf",
        disposition: "inline"
      end
    end
  end

  def new
    @post = current_user.posts.build
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      @subscribers = Subscriber.all
      @subscribers.all.each do |subscriber|
        SubscriberMailer.new_post(subscriber, @post).deliver
      end
      redirect_to @post, notice: 'Dodano nowy post.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Zaktualizowano post.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post został usunięty.'
  end

  private

  def set_post
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to posts_path, notice: "Nie jesteś uprawniony do edycji tego postu" if @post.nil?
  end

  def post_params
    params.require(:post).permit(:author, :description, :title, :image)
  end

end

class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.public_posts.includes(:author).page(params[:page])
    respond_with(@posts)
  end

  def show
    authorize(@post)
    respond_with(@post)
  end

  def new
    @post = current_user.posts.new(public: true)
    respond_with(@post)
  end

  def create
    @post = current_user.posts.create(post_params)
    respond_with(@post)
  end

  def edit
    authorize(@post)
    respond_with(@post)
  end

  def update
    authorize(@post)
    @post.update(post_params.merge(date_from_string))
    respond_with(@post)
  end

  def destroy
    authorize(@post)
    @post.destroy
    respond_with(@post)
  end

  def my_posts
    @posts = current_user.posts.page(params[:page])
    respond_with(@posts)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :public)
  end

  def date_from_string
    { created_at: DateTime.strptime(params[:post][:created_at], '%d.%m.%Y %H:%M')}
  end

  def load_post
    @post = Post.find(params[:id])
  end
end

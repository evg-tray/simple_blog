class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:create]
  before_action :load_comment, only: [:edit, :update, :destroy]

  respond_to :js, only: [:create]

  def create
    @comment = @post.comments.create(comment_params)
    respond_with(@comment)
  end

  def edit
    authorize(@comment)
    respond_with(@comment.post)
  end

  def update
    authorize(@comment)
    @comment.update(comment_params)
    if @comment.errors.present?
      respond_with(@comment)
    else
      redirect_to @comment.post
    end
  end

  def destroy
    authorize(@comment)
    @comment.destroy
    redirect_to @comment.post
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text).merge(author_id: current_user.id)
  end
end

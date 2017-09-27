class TagsController < ApplicationController

  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @posts = Post.public_posts.tagged_with(@tag.name).page(params[:page])
  end
end

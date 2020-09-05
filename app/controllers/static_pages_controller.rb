class StaticPagesController < ApplicationController
  def home
    @posts=current_user.feed.order(created_at: :desc).paginate(page: params[:page]) if login?
    @likeposts=current_user.like_posts_feed.paginate(page: params[:page])
    @tags=current_user.tags if login?
    @new_tag=current_user.tags.build if login?
    @user=current_user if login?
  end
end

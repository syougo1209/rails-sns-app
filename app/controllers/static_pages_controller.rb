class StaticPagesController < ApplicationController
  def home
    @posts=current_user.feed.order(created_at: :desc).paginate(page: params[:page]) if login?
  end

  def about
  end
end

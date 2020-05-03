class StaticPagesController < ApplicationController
  def home
    @posts=current_user.feed.paginate(page: params[:page]) if login?
  end

  def about
  end
end

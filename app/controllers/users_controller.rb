class UsersController < ApplicationController
    layout 'standard'
  def show
    @user = User.find(params[:id])
    @posts = Post.where(author_id: @user.id)
  end

  def index
    @users = User.all
  end
end

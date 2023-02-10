class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    respond_to do |format|
      format.html { render :new, locals: { comment: @comment } }
    end
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.create!(author_id: @user.id, post_id: @post.id, text: params[:my_comment][:text])
    if @comment.save
      flash[:success] = 'Succesfully created a comment'
      redirect_to user_post_path(@user.id, @post)
    else
      flash.new[:error] = 'encountered an error'
      render new, locals: { comment: @comment }
    end
  end

  def handle_params
    params.require(:my_comment).permit(:text)
  end
end

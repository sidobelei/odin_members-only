class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]

  def index
    if :authenticate_user!
      @posts = User.joins(:posts).select(:post_text, :username)
    else
      @posts = Post.select(:post_text)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_text: params[:post][:post_text], user_id: current_user.id)
    if @post.save
      redirect_to action: "index"
    else
      render :new
    end
  end
end

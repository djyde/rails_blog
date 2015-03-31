class PostsController < ApplicationController

  before_action :require_login, :except => [:index,:show]

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def show
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,autolink: true,table: true)
    @post = Post.find(params[:id])
    @title = @post.title
    @content = markdown.render(@post.content)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @new_post = current_user.posts.build(new_params)
    if @new_post.save
      redirect_to root_path
    end
  end

  def destroy
    if current_post.destroy
      redirect_to root_path
    end
  end

  def edit
    @post = current_post
  end

  def update
    if current_post.update(new_params)
      redirect_to root_path
    end
  end

  def about
    render 'about'
  end

  def archive
    @posts = Post.all.order("created_at DESC")
  end


  private

  def current_post
    if user_signed_in?
      current_user.posts.find(params[:id])
    end
  end

  def require_login
    if !user_signed_in?
      redirect_to new_user_session_path
    end
  end


  def new_params
    params.require(:post).permit(:title,:content)
  end
end

class BlogsController < ApplicationController
  
  def index
    @blogs = Blog.includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end
  
  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(create_params) 
    @blog.save
  end

  def destroy
    blog = Blog.find(params[:id])
    # blog = blog.where(id: params[:id])
    blog.destroy if blog.user_id == current_user.id
  end

  def update
    blog = Blog.find(params[:id])
    if blog.user_id == current_user.id
      blog.update(blog_params)
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def show
    @blog = Blog.find(params[:id])
  end

  private

  def create_params
    params.require(:blog).permit(:text).merge(user_id: current_user.id)
  end

  def blog_params
    params.permit(:image, :text)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
  
end
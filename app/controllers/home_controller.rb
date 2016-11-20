class HomeController < ApplicationController
  def index
    unless user_signed_in?
      redirect_to '/users/sign_in'
    end
    @post=Post.new
    @posts=Post.all.reverse
    #hashtag
    @hashtags = SimpleHashtag::Hashtag.all
    
    unless params[:hashtag].nil?
    @hashtag = SimpleHashtag::Hashtag.find_by_name(params[:hashtag])
    @hashtagged = @hashtag.hashtaggables if @hashtag     
    end
  end

  
  def create
    @post = Post.create(post_params)
    @post.save
    redirect_to :back
  end
  
  def edit
    @post = Post.find(params[:post_id])
    authorize @post
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end
  
  
  
  def update
     @post = Post.find(params[:post_id])
     authorize @post, :update?
     @post.update(post_params)
     
     redirect_to "/"
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    authorize @post, :update?
    @post.destroy
    
    redirect_to '/'
    
  end
  
  def searchtag
    @posts = Post.search(params[:search]).reverse
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :content, :user_id, :read_scope)
  end
  
end

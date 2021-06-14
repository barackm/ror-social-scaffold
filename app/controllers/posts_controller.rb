class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
    puts timeline_posts
    @users = User.where.not(id: current_user.id)
  end

  def create
    @post = current_user.posts.new(post_params)
    @users = User.where.not(id: current_user.id)
    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    @timeline_posts = Post.all.filter do |p|
      current_user.friends.any? { |f| f.id == p.user_id } || p.user_id == current_user.id
    end
    #     Post.all.each do |p|
    #       if current_user.friends.any? { |f| f.id == p.user_id }
    #         timeline_posts.push(p)
    #       elsif p.user_id == current_user.id
    #         timeline_posts.push(p)
    #       end
    #     end
    #     @timeline_posts
  end

  def post_params
    params.require(:post).permit(:content)
  end
end

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_group
  before_action :find_post, only:[:edit, :update, :destroy]
  before_action :member_required, only: [:new, :create]

  def new
    @post = @group.posts.new
  end

  def edit
  end

  def create
    @post = @group.posts.build(post_params)
    @post.author = current_user

    if @post.save
      current_user.join!(@group)
      redirect_to group_path(@group), notice: "Article is created!"
    else
      render :new
    end
  end

  def update

    if @post.update(post_params)
      redirect_to group_path(@group), notice: "Article is modified!"
    else
      render :edit
    end
  end

  def destroy

    @post.destroy
    redirect_to group_path(@group), alert: "Article is deleted!"
  end

  private

  def find_group
    @group = Group.find(params[:group_id])
  end

  def find_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end

  def member_required
    if !current_user.is_member_of?(@group)
      flash[:warning] = "You do not belong to this group, so I am afraid you can't post stuff. Sorry!"
      redirect_to group_path(@group)
    end
  end
end

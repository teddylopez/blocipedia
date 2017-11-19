class WikisController < ApplicationController
  after_action :verify_authorized, except: [:index, :show, :about]
  before_filter :authenticate_user!

  def index
    @user = current_user
    @wikis = Wiki.all.order("created_at DESC").paginate(page: params[:page], per_page: 5)
    @viewable_wikis = Wiki.find_view(@user, current_user, @wikis)
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    @wiki.user = current_user
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize @wiki

    if @wiki.save
      flash[:notice] = "\"#{@wiki.title}\" was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the entry. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.friendly.find(params[:id])
    @users = User.all
    @collaborator = Collaborator.new
    authorize @wiki
  end

  def update
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki

    @wiki.assign_attributes(wiki_params)
    @wiki.user_ids = params[:wiki][:user_ids] if params[:wiki][:user_ids].present?

    if @wiki.save
      flash[:notice] = "\"#{@wiki.title}\" has been updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error updating the entry. Please try again."
      render :edit
    end
  end

    def destroy
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" has been deleted."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :slug, :private, :user_id, :user_ids)
  end

end

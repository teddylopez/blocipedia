class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :about]

  #after_action :verify_authorized, except: :index
  #after_action :verify_policy_scoped, except: :index

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    @wiki.user_id = current_user.id
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user_id = current_user.id
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
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.assign_attributes(wiki_params)
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    if @wiki.save
      flash[:notice] = "\"#{@wiki.title}\" has been updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error updating the entry. Please try again."
      render :edit
    end
  end

    def destroy
    @wiki = Wiki.find(params[:id])
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
    params.require(:wiki).permit(:title, :body, :private)
  end

end

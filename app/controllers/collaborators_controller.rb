class CollaboratorsController < ApplicationController

  def new
    @collaborator = Collaborator.new
  end

  def create
    @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: params[:user_id])

    if @collaborator.save
      flash[:notice] = "Collaborator has been added."
      redirect_to @wiki
    else
      flash[:error] = "Collaborator was not added."
      render :show
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator has been removed."
      redirect_to @wiki
    else
      flash[:error] = "Collaborator was not removed."
      render :show
    end
  end

end

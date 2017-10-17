class UserController < ApplicationController

  def show
    if current_user.present?
      @user = params[:id] ? User.find(params[:id]) : current_user
    else
      redirect_to root_path
    end
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.assign_attributes(user_params)
    if @user.role == :admin
      @user.admin == true
    else
      @user.admin == false
    end

    if @user.save
      flash[:notice] = "\"#{@user.email}\" has been updated."
      redirect_to @user
    else
      flash.now[:alert] = "There was an error updating the entry. Please try again."
      render :edit
    end
  end

  def downgrade
    current_user.role = 'standard'
    if current_user.save
      flash[:notice] = "You've been downgraded to a standard account. Your private wikis are now public."
      current_user.wikis.each { |wiki| wiki.update_attribute(:private, false) }
      redirect_to root_path
    else
      flash[:error] = "There was an error editing your account. Please try again."
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :role, :admin)
  end

  def role_check
    if self.role == :admin
      self.admin == true
    else
      self.admin == false
    end
  end

end

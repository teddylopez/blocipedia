class WelcomeController < ApplicationController
  #before_filter :authenticate_user!, except: [ :home, :about ]
  def index
  end

  def about
  end

  def home
    if current_user
      @my_wikis = Wiki.where(:user_id => current_user.id).all.limit(5).order('updated_at DESC')
    end
  end
end

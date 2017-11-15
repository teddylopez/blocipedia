class WelcomeController < ApplicationController
  before_filter :authenticate_user!, except: [ :home, :about ]
  def index
  end

  def about
  end

  def home
  end
end

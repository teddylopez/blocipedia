class UserController < ApplicationController

def downgrade
  current_user.role = 'standard'
  if current_user.save
    flash[:notice] = "You've been downgraded to a standard account. Your private wikis are now public."
    redirect_to root_path
  else
    flash[:error] = "There was an error editing your account. Please try again."
    redirect_to root_path
  end
end

end

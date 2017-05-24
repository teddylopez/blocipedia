require 'rails_helper'

RSpec.describe User, type: :model do
  sign_in @user
  sign_in @user, scope: :admin
end

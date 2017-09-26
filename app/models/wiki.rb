class Wiki < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators


  def private?
    self.private == true
  end

  private

  def make_public
    self.private == false
  end

end

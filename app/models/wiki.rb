class Wiki < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  scope :visible_to, -> (user) { user ? where(private: false) : 'There was an error.' }

  def private?
    self.private == true
  end

  private

  def make_public
    self.private == false
  end

end

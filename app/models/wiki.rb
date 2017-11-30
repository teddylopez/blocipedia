class Wiki < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  validates :title, presence: true, length: {minimum: 1 }
  validates :body, presence: true

  def private?
    self.private == true
  end

  def self.find_view(user, current_user, wikis)
    @viewable_wikis = []
    wikis.each do |wiki|
      if (wiki.user == current_user || !wiki.private? || wiki.collaborators.include?(user))
        @viewable_wikis << wiki
      end
    end
  end

  def self.search(params)
    wikis = Wiki.where("title like ? or body like ?", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
  end

  private

  def make_public
    self.private == false
  end

end

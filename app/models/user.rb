class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis
  has_many :collaborators
  has_many :wikis, through: :collaborators

  before_save :init
  after_initialize :role_check
  after_save :role_check

  enum role: [:standard, :premium, :admin]

  def init
    self.role ||= :standard
  end

  def role_check
    if self.role == :admin
      self.admin == true
    else
      self.admin == false
    end
  end

end

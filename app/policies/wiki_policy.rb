class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    false
    # user.present?
  end

  def create?
    user.present?
    user && user.profile.addresses.exists?(address.id)
  end

  def update?
    #user && user.wiki.exists?(wiki.id)
    user.present? #&& user == wiki.user
  end

  def edit
    user.present?
  end

  def destroy?
    # user.admin?
    # user.present?
    user && user.wiki.exists?(wiki.id)
  end

  private
    def wiki
      record
    end
end

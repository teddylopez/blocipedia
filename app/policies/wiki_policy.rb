class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    user.present?
  end

  def update?
    create?
  end

  def edit?
    create?
  end

  def new?
    create?
  end

  def destroy?
    # user.admin?
    # user.present?
    create?
  end

  private
    def wiki
      record
    end

end

class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    user.present? #&& (!wiki.private || user.admin? || wiki.user_id = user.id)
  end

  def create?
    user.present?
  end

  def update?
    create?
  end

  def edit?
    case record.private
      when false
        true if user.present?
      when true
        true if user.present? && (user.admin? || record.user_id = user.id)
      else
        true
      end
  end

  def new?
    create?
  end

  def destroy?
    user.present? && (user.admin? || record.user_id == user.id)
  end

  private
    def wiki
      record
    end

end

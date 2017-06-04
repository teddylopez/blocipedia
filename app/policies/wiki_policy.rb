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

  class Scope
    attr_reader :user, :scope
      def initialize(user, scope)
        @user = user
        @scope = scope
      end

    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all # if the user is an admin, show them all the wikis
        elsif user.role == 'premium'
          all_wikis = scope.all
          all_wikis.each do |wiki|
            if !wiki.private? || wiki.user_id == user.id || wiki.collaborators.include?(user)
              wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
            end
        end
      else # this is the lowly standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.collaborators.include?(user)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      wikis # return the wikis array we've built up
    end
  end

  private
    def wiki
      record
    end

end

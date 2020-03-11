class RulePolicy < ApplicationPolicy
    class Scope < Scope
    def resolve
      scope.all
    end
  end
  def create?
    user.class == Admin
  end

  def destroy?
    user.class == Admin
  end
end

class RoutePolicy < ApplicationPolicy
    class Scope < Scope
    def resolve
      scope.all
    end
  end
  def create?
  end

  def destroy?
  end
end

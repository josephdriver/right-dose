class CaseDrugPolicy < ApplicationPolicy
  class Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.class == Paramedic
  end

  def destroy?
    user.class == Paramedic
  end
end

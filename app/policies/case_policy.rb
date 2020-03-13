class CasePolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    user.class == Paramedic
  end
end

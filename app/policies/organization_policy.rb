class OrganizationPolicy < ApplicationPolicy
    class Scope < Scope
    def resolve
      scope.all
    end
  end
  def update?
    user.class == Admin
  end
end

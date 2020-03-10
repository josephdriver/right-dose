class OrganizationPolicy < ApplicationPolicy
  def update?
    user.class == Admin
  end
end

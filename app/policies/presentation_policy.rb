class PresentationPolicy < ApplicationPolicy

  def create?
    user.class == Admin
  end

  def destroy?
    user.class == Admin
  end
end

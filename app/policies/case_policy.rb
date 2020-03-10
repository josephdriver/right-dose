class CasePolicy < ApplicationPolicy
  def create?
    user.class == Paramedic
  end
end

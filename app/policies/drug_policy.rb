class DrugPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create
  end

  def update
  end

  def destroy
  end
end

class WarehousePolicy < ApplicationPolicy
  def create?
    user.admin?
  end
end

class PowerBankPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def assign_to_station?
    user.admin?
  end

  def assign_to_warehouse?
    user.admin?
  end

  def assign_to_user?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: nil)
      end
    end
  end
end
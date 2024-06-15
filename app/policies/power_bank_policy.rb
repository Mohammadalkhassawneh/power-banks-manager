class PowerBankPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def assign_to_station?
    user.admin?
  end
end
class StationPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def assign_power_bank?
    user.admin?
  end

  def view_power_banks?
    user.normal_user?
  end
end

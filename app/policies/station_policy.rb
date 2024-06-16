class StationPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def assign_power_bank?
    user.admin?
  end

  def index?
    true
  end

  def show?
    true
  end

  def available_power_banks?
    true
  end

  def take_power_bank?
    true
  end

  def return_power_bank?
    true
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.joins(:power_banks).where(power_banks: { user_id: nil }).distinct
      end
    end
  end
end

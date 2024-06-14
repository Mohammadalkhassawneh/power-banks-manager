class Station < ApplicationRecord
  belongs_to :location, optional: true
  belongs_to :warehouse, optional: true
  has_many :power_banks

  validates :name, presence: true
  validates :status, inclusion: { in: %w[online offline] }

  validate :validate_power_banks_count

  private

  def validate_power_banks_count
    errors.add(:base, 'Station cannot contain more than 10 Power Banks') if power_banks.size > 10
  end
end

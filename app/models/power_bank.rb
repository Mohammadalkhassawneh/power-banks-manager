class PowerBank < ApplicationRecord
  belongs_to :station, optional: true
  belongs_to :warehouse, optional: true
  belongs_to :user, optional: true

  validates :serial_number, presence: true, uniqueness: true
  validate :validate_station_capacity

  enum status: [:online, :offline]

  def self.ransackable_attributes(auth_object = nil)
    %w[id serial_number station_id status]
  end

  private

  def validate_station_capacity
    if station && station.power_banks.count >= 10
      errors.add(:station_id, "cannot have more than 10 power banks")
    end
  end
end

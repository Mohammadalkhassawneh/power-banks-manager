require 'rails_helper'

RSpec.describe PowerBank, type: :model do
  subject { described_class.new(serial_number: "PB12345") }

  describe "validations" do
    it { should validate_uniqueness_of(:serial_number) }

    it "validates the presence of serial_number" do
      should validate_presence_of(:serial_number)
    end

    it "validates the optional associations" do
      should belong_to(:station).optional
      should belong_to(:warehouse).optional
      should belong_to(:user).optional
    end

    it "validates station capacity" do
      station = create(:station)
      10.times { create(:power_bank, station: station) }  # Create 10 power banks for the station
      power_bank = build(:power_bank, station: station)
      expect(power_bank).not_to be_valid
      expect(power_bank.errors[:station_id]).to include("cannot have more than 10 power banks")
    end
  end

  describe "associations" do
    it { should belong_to(:station).optional }
    it { should belong_to(:warehouse).optional }
    it { should belong_to(:user).optional }
  end
end

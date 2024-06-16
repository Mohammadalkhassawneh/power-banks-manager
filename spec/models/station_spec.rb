
require 'rails_helper'

RSpec.describe Station, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:status) }
end
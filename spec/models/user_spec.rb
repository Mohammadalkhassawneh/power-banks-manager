require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  describe "methods" do
    it "generates a valid JWT token" do
      user = create(:user)
      token = user.generate_jwt
      decoded_token = JWT.decode(token, Rails.application.credentials.dig(:devise, :jwt_secret_key)).first
      expect(decoded_token['id']).to eq(user.id)
    end
  end
end

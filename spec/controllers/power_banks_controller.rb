require 'rails_helper'

RSpec.describe PowerBanksController, type: :controller do
  let(:valid_attributes) {
    attributes_for(:power_bank)
  }

  let(:invalid_attributes) {
    { serial_number: nil }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      power_bank = PowerBank.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      power_bank = PowerBank.create! valid_attributes
      get :show, params: { id: power_bank.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new PowerBank" do
        expect {
          post :create, params: { power_bank: valid_attributes }, session: valid_session
        }.to change(PowerBank, :count).by(1)
      end

      it "renders a JSON response with the new power_bank" do
        post :create, params: { power_bank: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(power_bank_url(PowerBank.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new power_bank" do
        post :create, params: { power_bank: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      let(:new_attributes) {
        { serial_number: "PB67890" }
      }

      it "updates the requested power_bank" do
        power_bank = PowerBank.create! valid_attributes
        patch :update, params: { id: power_bank.to_param, power_bank: new_attributes }, session: valid_session
        power_bank.reload
        expect(power_bank.serial_number).to eq("PB67890")
      end

      it "renders a JSON response with the power_bank" do
        power_bank = PowerBank.create! valid_attributes
        patch :update, params: { id: power_bank.to_param, power_bank: valid_attributes }, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the power_bank" do
        power_bank = PowerBank.create! valid_attributes
        patch :update, params: { id: power_bank.to_param, power_bank: invalid_attributes }, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested power_bank" do
      power_bank = PowerBank.create! valid_attributes
      expect {
        delete :destroy, params: { id: power_bank.to_param }, session: valid_session
      }.to change(PowerBank, :count).by(-1)
    end
  end
end

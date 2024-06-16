# spec/controllers/stations_controller_spec.rb
require 'rails_helper'

RSpec.describe StationsController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:station) { create(:station) }
  let(:valid_attributes) { attributes_for(:station) }
  let(:invalid_attributes) { { name: '', status: '' } }

  before do
    request.headers['Authorization'] = "Bearer #{admin.generate_jwt}"
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: station.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Station" do
        expect {
          post :create, params: { station: valid_attributes }
        }.to change(Station, :count).by(1)
      end

      it "renders a JSON response with the new station" do
        post :create, params: { station: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new station" do
        post :create, params: { station: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested station" do
      station = Station.create! valid_attributes
      expect {
        delete :destroy, params: { id: station.id }
      }.to change(Station, :count).by(-1)
    end
  end

  describe "role-based access" do
    it "allows admin to create a station" do
      expect {
        post :create, params: { station: valid_attributes }
      }.to change(Station, :count).by(1)
    end

    it "denies non-admin users from creating a station" do
        debugger
      request.headers['Authorization'] = "Bearer #{user.generate_jwt}"
      post :create, params: { station: valid_attributes }
      expect(response).to have_http_status(:forbidden)
    end
  end
end

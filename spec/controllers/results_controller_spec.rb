# spec/controllers/results_controller_spec.rb
require 'rails_helper'

RSpec.describe ResultsController, type: :controller do
  let(:user) { create(:user) }
  let(:wheel) { create(:wheel) }

  before do
    sign_in user
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_attributes) { { participant_name: "John Doe", wheel_id: wheel.id } }

      it "creates a new result" do
        expect {
          post :create, params: valid_attributes, format: :json
        }.to change(Result, :count).by(1)
      end

      it "renders a JSON response with the new result" do
        post :create, params: valid_attributes, format: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)["participant_name"]).to eq("John Doe")
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { participant_name: "", wheel_id: wheel.id } }

      it "does not create a new result" do
        expect {
          post :create, params: invalid_attributes, format: :json
        }.to change(Result, :count).by(0)
      end
    end
  end
end

require "rails_helper"

RSpec.describe WheelsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:wheel) { create(:wheel, user: user) }
  let!(:participant1) { create(:participant, wheel: wheel, name: "Alice") }
  let!(:participant2) { create(:participant, wheel: wheel, name: "Bob") }

  it "should redirect new when not logged in" do
    expect(get(:new)).to redirect_to new_user_session_path
  end

  describe "when logged in" do
    before do
      sign_in user
    end

    it "should show wheel" do
      get :show, params: {id: wheel.id}

      expect(response.code).to eq("200")
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "creates a new wheel" do
          expect {
            post :create, params: {wheel: {title: "Valid Title", user_id: user.id}}
          }.to change(Wheel, :count).by(1)
        end

        it "redirects to the new wheel" do
          post :create, params: {wheel: {title: "Valid Title", user_id: user.id}}
          expect(response).to redirect_to(Wheel.last)
        end
      end

      context "with invalid attributes" do
        it "does not save the new wheel" do
          expect {
            post :create, params: {wheel: {title: nil, user_id: user.id}}
          }.not_to change(Wheel, :count)
        end

        it "re-renders the new template" do
          post :create, params: {wheel: attributes_for(:wheel, title: nil)}
          expect(response).to redirect_to(new_wheel_path)
        end
      end
    end

    describe "DELETE #destroy" do
      it "deletes the wheel" do
        wheel
        expect {
          delete :destroy, params: {id: wheel.id}
        }.to change(Wheel, :count).by(-1)
      end

      it "redirects to wheels#index" do
        delete :destroy, params: {id: wheel.id}
        expect(response).to redirect_to(wheels_path)
      end
    end
    before do
      get :show, params: {id: wheel.id}
    end

    it "doesnt change participants when no edits are made" do
      patch :update, params: {id: wheel.id}
      wheel.reload
      expect(wheel.participants.map(&:name)).to match_array(["Alice", "Bob"])
    end

    it "re-renders the show template on failure" do
      allow_any_instance_of(Wheel).to receive(:update).and_return(false)
      patch :update, params: {id: wheel.id, temp_participants: []}
      expect(response).to redirect_to(wheel)
    end

    it "adds new participants" do
      post :temp_create, params: {id: wheel.id, name: "Joe"}
      post :temp_create, params: {id: wheel.id, name: "Steve"}
      post :temp_create, params: {id: wheel.id, name: "Steve"}
      patch :update, params: {id: wheel.id}
      wheel.reload

      expect(wheel.participants.map(&:name)).to match_array(["Alice", "Bob", "Joe", "Steve", "Steve"])
    end

    it "Removes participants" do
      post :temp_create, params: {id: wheel.id, name: "Bob"}
      post :temp_delete, params: {id: wheel.id, participant_id: participant2.id.to_s}
      patch :update, params: {id: wheel.id}
      wheel.reload
      expect(wheel.participants.map(&:name)).to match_array(["Bob", "Alice"])
    end
  end
end

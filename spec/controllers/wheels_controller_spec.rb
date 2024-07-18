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
          expect(response).to redirect_to(wheels_path)
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

    describe "Participant editing" do
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
        # Add new participants using temp_create
        post :temp_create, params: {id: wheel.id, name: "Joe"}, as: :json
        post :temp_create, params: {id: wheel.id, name: "Steve"}, as: :json
        post :temp_create, params: {id: wheel.id, name: "Steve"}, as: :json

        # Update the wheel participants
        patch :update, params: {id: wheel.id}
        wheel.reload

        # Check if participants were added correctly
        expect(wheel.participants.map(&:name)).to match_array(["Alice", "Bob", "Joe", "Steve", "Steve"])
      end

      it "Removes participants" do
        post :temp_delete, params: {id: wheel.id, participant_id: participant2.id.to_s}, as: :json
        patch :update, params: {id: wheel.id}
        wheel.reload
        expect(wheel.participants.map(&:name)).to match_array(["Alice"])
      end

      it "Resets unsaved changes" do
        post :temp_create, params: {id: wheel.id, name: "Joe"}, as: :json
        post :temp_delete, params: {id: wheel.id, participant_id: participant2.id.to_s}, as: :json
        post :reset_participants, params: {id: wheel.id}
        temp_participants = session["temp_participants_#{wheel.id}"]
        expect(temp_participants.map { |p| p[:name] }).to match_array(["Alice", "Bob"])
      end
    end

    describe "Participant sorting" do
      it "sorts participants alphabetically by name" do
        post :temp_create, params: {id: wheel.id, name: "Charlie"}, as: :json
        post :sort_alphabetically, params: {id: wheel.id}
        temp_participants = session["temp_participants_#{wheel.id}"]
        expect(temp_participants.map { |p| p[:name] }).to eq(["Alice", "Bob", "Charlie"])
      end

      it "shuffles participants" do
        post :temp_create, params: {id: wheel.id, name: "Charlie"}, as: :json
        post :temp_create, params: {id: wheel.id, name: "John"}, as: :json
        original_order = session["temp_participants_#{wheel.id}"].dup
        shuffled_differently = false

        # Checks five times to lower the chance that the shuffle returns the same order and the test fails
        5.times do
          post :shuffle, params: {id: wheel.id}
          temp_participants = session["temp_participants_#{wheel.id}"]
          if temp_participants != original_order
            shuffled_differently = true
            break
          end
        end
        expect(shuffled_differently).to be true
      end
    end
  end
end

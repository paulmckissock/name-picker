require "rails_helper"

RSpec.describe WheelsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:wheel) { create(:wheel, user: user) }
  let!(:participant1) { create(:participant, wheel: wheel, name: "Alice") }
  let!(:participant2) { create(:participant, wheel: wheel, name: "Bob") }

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

  # describe 'PATCH #save' do
  #   before do
  #     get :edit, params: { id: wheel.id }
  #   end

  #   it 'doesnt change participants when no edits are made' do
  #     patch :save, params: { id: wheel.id}
  #     wheel.reload
  #     expect(wheel.participants.map(&:name)).to match_array(['Alice', 'Bob'])
  #   end

  #   it 're-renders the show template on failure' do
  #     allow_any_instance_of(Wheel).to receive(:save).and_return(false)
  #     patch :save, params: { id: wheel.id, temp_participants: [] }
  #     expect(response).to redirect_to(edit_wheel_path(wheel))
  #   end
  # end

  # it 'adds new participants' do
  #   post :temp_create, params: {id: wheel.id, name: 'Joe'}
  #   patch :save, params: { id: wheel.id}
  #   expect(wheel.participants.map(&:name)).to match_array(['Alice', 'Bob', 'Joe'])
  # end
end

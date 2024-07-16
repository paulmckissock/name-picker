class WheelsController < ApplicationController
  before_action :authenticate_user!

  def index
    @wheels = current_user.wheels
  end

  def show
    @participant = Participant.new
  end

  def new
    @wheel = Wheel.new
  end

  def create
    @wheel = Wheel.new(wheel_params)
    wheel.user = User.first
    if wheel.save
      redirect_to wheel
    else
      redirect_to new_wheel_path
    end
  end

  def destroy
    wheel.destroy
    redirect_to wheels_path
  end

  # Waiting until user login is setup to make these work
  #
  def temp_create
    load_participants
    temp_participants << Participant.new(name: params[:name], wheel: wheel)
    save_temp_participants
  end

  def temp_delete
    load_participants
    temp_participants.reject! { |p| p[:id].to_s == params[:participant_id] }
    save_temp_participants
  end

  def update
    load_participants
    update_participants

    if wheel.save
      flash[:notice] = "Participants updated successfully."
    else
      flash[:alert] = "Error updating participants."
    end
    redirect_to wheel
  end

  private

  def wheel
    @wheel ||= Wheel.find(params[:id])
  end

  def wheel_params
    params.require(:wheel).permit(:title)
  end

  def temp_participants
    @temp_participants ||= wheel.participants.to_a
  end

  def temp_participants_key
    "temp_participants_#{wheel.id}"
  end

  def save_temp_participants
    session[temp_participants_key] = @temp_participants
  end

  def load_participants
    @temp_participants = session[temp_participants_key] || temp_participants
  end

  def update_participants
    # Creates participants that are not in wheel.participants already
    load_participants
    temp_participants.each do |participant|
      unless wheel.participants.exists?(id: participant.id)
        wheel.participants.build(name: participant.name)
      end
    end

    # Deletes participants that are not in temp_participants
    wheel.participants.each do |participant|
      unless temp_participants.any? { |temp_participant| temp_participant[:id] == participant.id }
        participant.destroy
      end
    end
  end
end

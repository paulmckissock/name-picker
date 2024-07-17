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

  def sort_alphabetically
    load_temp_participants
    @temp_participants.sort_by! { |participant| participant[:name].downcase }
    save_temp_participants
  end

  def shuffle
    load_temp_participants
    @temp_participants.shuffle!
    save_temp_participants
  end

  def destroy
    wheel.destroy
    redirect_to wheels_path
  end

  def temp_create
    load_temp_participants
    temp_participants << Participant.new(name: params[:name], wheel: wheel)
    save_temp_participants
  end

  def temp_delete
    load_temp_participants
    temp_participants.reject! { |p| p[:id].to_s == params[:participant_id] }
    save_temp_participants
  end

  def update
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

  def load_temp_participants
    @temp_participants = session[temp_participants_key] || temp_participants
  end

  def update_participants
    # Creates participants that are not in wheel.participants already
    load_temp_participants
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

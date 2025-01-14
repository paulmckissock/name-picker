class WheelsController < ApplicationController
  before_action :authenticate_user!

  def index
    @wheels = current_user.wheels
  end

  def show
    @participant = Participant.new
    @results = wheel.results.order(created_at: :desc)
    load_temp_participants
  end

  def new
    @wheel = Wheel.new
  end

  def create
    @wheel = Wheel.new(wheel_params)
    wheel.user = current_user
    if wheel.save
      redirect_to wheel
    else
      redirect_to wheels_path
    end
  end

  def sort_alphabetically
    load_temp_participants
    temp_participants.sort_by! { |participant| participant.downcase }
    save_temp_participants

    respond_to do |format|
      format.json { render json: temp_participants.to_json }
    end
  end

  def shuffle
    load_temp_participants
    temp_participants.shuffle!
    save_temp_participants
    respond_to do |format|
      format.json { render json: temp_participants.to_json }
    end
  end

  def destroy
    wheel.destroy
    redirect_to wheels_path
  end

  def temp_create
    load_temp_participants
    temp_participants << params[:name]
    save_temp_participants
    respond_to do |format|
      format.json { render json: temp_participants.to_json }
    end
  end

  def temp_delete
    load_temp_participants
    temp_participants.delete_at(temp_participants.index(params[:name]))
    save_temp_participants
    respond_to do |format|
      format.json { render json: temp_participants.to_json }
    end
  end

  def reset_participants
    @temp_participants = wheel.participants.pluck(:name)
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

  def check_unsaved_changes
    load_temp_participants
    render json: {unsaved_changes: temp_participants != wheel.participants.pluck(:name)}
  end

  private

  def wheel
    @wheel ||= Wheel.find(params[:id])
  end

  def wheel_params
    params.require(:wheel).permit(:title)
  end

  def participant_params
    params.require(:participant).permit(:name)
  end

  def temp_participants
    @temp_participants ||= wheel.participants.pluck(:name)
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
    wheel.participants.destroy_all
    temp_participants.each do |participant|
      wheel.participants.create(name: participant)
    end
  end
end

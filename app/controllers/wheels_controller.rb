class WheelsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :new, :create]
  def index
    # will be all wheels of current user when user login is setup
    @wheels = Wheel.all
  end

  def show
  end

  def edit
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
  # def temp_create
  #   temp_participants << Participant.new(name: params[:name], wheel: wheel)
  #   byebug
  # end

  # def temp_delete
  #   participant_name = params[:participant_name]
  #   @temp_participants.reject! { |p| p.name == participant_name }
  # end

  # def save
  #   update_participants(wheel, temp_participants)

  #   if wheel.save
  #     flash[:notice] = 'Participants updated successfully.'
  #     redirect_to wheel
  #   else
  #     flash[:alert] = 'Error updating participants.'
  #     redirect_to edit_wheel_path(wheel.id)
  #   end
  # end

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

  # def update_participants(wheel, temp_participants)
  # Add new participants
  # temp_participants.each do |participant|
  #   unless wheel.participants.exists?(name: participant.name)
  #     wheel.participants.build(name: participant.name)
  #   end
  # end

  # Remove participants that are not in temp_participants
  # wheel.participants.each do |participant|
  #   unless temp_participants.map(&:name).include?(participant.name)
  #     participant.destroy
  #   end
  # end
  # end
end

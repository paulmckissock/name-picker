class WheelsController < ApplicationController
  def index
  end

  def show
    @participants = wheel.participants
    @participants_text = wheel.participants.pluck(:name).join("\n")
  end

  def new
    @wheel = Wheel.new
  end

  def create
    @wheel = Wheel.new(wheel_params)
    if wheel.save
      redirect_to wheel
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update_participants
    participant_names = params[:participants_text].split("\n").map(&:strip).reject(&:blank?)
    
    # Remove participants not in the new list
    wheel.participants.where.not(name: participant_names).destroy_all

    # Add new participants
    participant_names.each do |name|
      wheel.participants.find_or_create_by(name: name)
    end
    redirect_to wheel
  end

  def spin_wheel
    @winner = wheel.participants.sample
    @result = Result.new(participant: @winner, wheel: wheel)
    
    unless result.save
      render :new, status: :unprocessable_entity
    end
  end 

  private

  def wheel
    @wheel ||= Wheel.find(params[:id])
  end
  
  def wheel_params
    params.require(:wheel).permit(:title)
  end
end

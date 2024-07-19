class ResultsController < ApplicationController
  before_action :authenticate_user!
  def create
    @result = Result.new(
      wheel_id: wheel.id,
      user: current_user,
      participant_name: params[:participant_name].to_s
    )

    if @result.save
      respond_to do |format|
        format.json { render json: @result }
      end
    else
      respond_to do |format|
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def wheel
    @wheel ||= Wheel.find(params[:wheel_id])
  end
end

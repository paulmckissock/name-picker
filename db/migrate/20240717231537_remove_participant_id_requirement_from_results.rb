class RemoveParticipantIdRequirementFromResults < ActiveRecord::Migration[7.1]
  def change
    change_column_null :results, :participant_id, true
  end
end

class RemoveParticipantFromResults < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :results, :participants
    change_column_null :results, :participant_id, true
  end
end

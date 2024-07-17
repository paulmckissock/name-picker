class AddParticipantNameToResults < ActiveRecord::Migration[7.1]
  def change
    add_column :results, :participant_name, :string
  end
end

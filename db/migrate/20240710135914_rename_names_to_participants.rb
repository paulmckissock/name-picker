class RenameNamesToParticipants < ActiveRecord::Migration[7.1]
  def change
    rename_table :names, :participants
  end
end

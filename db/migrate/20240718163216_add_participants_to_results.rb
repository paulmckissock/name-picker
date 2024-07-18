class AddParticipantsToResults < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :results, :participants, null: true
  end
end

class AddParticipantsCountToWheels < ActiveRecord::Migration[7.1]
  def change
    add_column :wheels, :participants_count, :integer, default: 0, null: false
  end
end

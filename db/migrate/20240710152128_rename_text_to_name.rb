class RenameTextToName < ActiveRecord::Migration[7.1]
  def change
    rename_column :participants, :text, :name
  end
end

class CreateWheels < ActiveRecord::Migration[7.1]
  def change
    create_table :wheels do |t|
      t.string :title, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end

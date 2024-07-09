class CreateNames < ActiveRecord::Migration[7.1]
  def change
    create_table :names do |t|
      t.references :wheel, foreign_key: true, null: false
      t.string :text, null: false
      t.timestamps
      t.boolean :has_won, default: false, null: false
    end
  end
end

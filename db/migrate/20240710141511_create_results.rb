class CreateResults < ActiveRecord::Migration[7.1]
  def change
    create_table :results do |t|
      t.references :participant, null: false, foreign_key: true
      t.references :user, foreign_key: true
      t.references :wheel, null: false, foreign_key: true

      t.timestamps
    end
  end
end

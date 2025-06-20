class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.references :board, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.integer :status, null: false

      t.timestamps
    end
  end
end

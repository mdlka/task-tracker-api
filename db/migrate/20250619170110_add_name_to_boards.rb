class AddNameToBoards < ActiveRecord::Migration[8.0]
  def change
    add_column :boards, :name, :string, null: false
  end
end

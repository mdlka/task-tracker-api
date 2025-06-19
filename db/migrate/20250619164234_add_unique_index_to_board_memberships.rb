class AddUniqueIndexToBoardMemberships < ActiveRecord::Migration[8.0]
  def change
    add_index :board_memberships, [ :user_id, :board_id ], unique: true
  end
end

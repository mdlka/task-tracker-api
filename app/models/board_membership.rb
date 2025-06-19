class BoardMembership < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validates_uniqueness_of :user_id, scope: :board_id, message: "has already been added"
  validate :user_is_not_board_owner

  private

  def user_is_not_board_owner
    errors.add(:user, "cannot be added as member because they are the board owner") if user_id == board&.user_id
  end
end

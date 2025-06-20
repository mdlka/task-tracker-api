class Board < ApplicationRecord
  belongs_to :user
  has_many :board_memberships
  has_many :users, through: :board_memberships
  has_many :tasks

  validates :name, presence: true

  def owner?(user_id)
    self.user_id == user_id
  end

  def member?(user_id)
    BoardMembership.exists?(board_id: self.id, user_id: user_id)
  end
end

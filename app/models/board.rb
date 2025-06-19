class Board < ApplicationRecord
  belongs_to :user
  has_many :board_memberships
  has_many :users, through: :board_memberships
end

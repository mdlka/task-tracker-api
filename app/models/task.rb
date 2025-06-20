class Task < ApplicationRecord
  belongs_to :board

  enum :status, [ :to_do, :in_progress, :done ], validate: true

  validates :title, presence: true

  def belongs_to_board?(board_id)
    self.board_id == board_id.to_i
  end
end

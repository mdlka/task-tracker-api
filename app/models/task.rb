class Task < ApplicationRecord
  belongs_to :board

  enum :status, [ :to_do, :in_progress, :done ], validate: true

  validates :title, presence: true
end

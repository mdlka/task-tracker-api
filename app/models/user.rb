class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  has_one :board
  has_many :board_memberships
  has_many :boards, through: :board_memberships

  validates :password_confirmation, presence: true, on: %i[create update]
end

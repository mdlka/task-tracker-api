class Api::BoardMembershipsController < ApplicationController
  include BoardAccessible

  before_action :authenticate_user!
  before_action :validate_view_board_access!, only: [ :index ]
  before_action :validate_edit_board_access!, only: [ :update, :destroy ]

  def index
    members = find_board.users
    render json: UserResource.new(members).serialize
  end

  def update
    membership = BoardMembership.new(membership_params)

    if membership.save
      render json: BoardMembershipResource.new(membership).serialize
    else
      render json: { errors: membership.errors.full_messages }, status: :unprocessable_content
    end
  end

  def destroy
    membership = BoardMembership.find_by(membership_params)
    head :not_found unless membership&.destroy
  end

  private

  def membership_params
    { board_id: params[:board_id], user_id: params[:id] }
  end
end

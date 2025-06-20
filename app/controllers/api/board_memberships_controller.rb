class Api::BoardMembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_board_access!

  def index
    members = Board.find(params[:board_id]).users.all
    render json: UserResource.new(members).serialize, status: :ok
  end

  def update
    membership = BoardMembership.new(membership_params)

    if membership.save
      render json: BoardMembershipResource.new(membership).serialize, status: :ok
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

  def validate_board_access!
    head :forbidden unless board_owner?
  end

  def board_owner?
    Board.find(params[:board_id]).user_id == current_user.id
  end
end

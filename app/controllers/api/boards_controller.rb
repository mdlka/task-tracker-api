class Api::BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: [ :show, :update, :destroy ]
  before_action :validate_edit_board_access!, only: [ :update, :destroy ]
  before_action :validate_view_board_access!, only: [ :show ]

  def index
    boards = Board.left_joins(:board_memberships)
                  .where(user_id: current_user.id)
                  .or(Board.left_joins(:board_memberships)
                           .where(board_memberships: { user_id: current_user.id }))
                  .distinct

    render json: BoardResource.new(boards).serialize
  end

  def show
    render json: BoardResource.new(@board).serialize
  end

  def create
    board = Board.new(board_params.merge(user_id: current_user.id))

    if board.save
      render json: BoardResource.new(board).serialize, status: :created, location: api_board_url(board)
    else
      render json: { errors: board.errors.full_messages }, status: :unprocessable_content
    end
  end

  def update
    if @board.update(board_params)
      render json: BoardResource.new(@board).serialize
    else
      render json: { errors: board.errors.full_messages }, status: :unprocessable_content
    end
  end

  def destroy
    @board.destroy
  end

  private

  def board_params
    params.expect(board: [ :name ])
  end

  def set_board
    @board = Board.find(params[:id])
  end

  def validate_edit_board_access!
    head :forbidden unless board_owner?
  end

  def validate_view_board_access!
    head :forbidden unless board_owner? || board_member?
  end

  def board_owner?
    @board.user_id == current_user.id
  end

  def board_member?
    BoardMembership.exists?(board_id: @board.id, user_id: current_user.id)
  end
end

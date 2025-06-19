class Api::BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: [ :show, :destroy ]
  before_action :validate_board_access!, only: [ :show, :destroy ]

  def index
    render json: Board.where(user_id: current_user.id)
  end

  def show
    render json: @board
  end

  def create
    board = Board.new(board_params.merge(user_id: current_user.id))

    if board.save
      render json: board, status: :created, location: api_board_url(board)
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

  def validate_board_access!
    head :forbidden unless @board.user_id == current_user.id
  end
end

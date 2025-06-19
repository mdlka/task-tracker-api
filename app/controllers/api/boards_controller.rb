class Api::BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: [ :show, :destroy ]
  before_action :valid_board_access, only: [ :show, :destroy ]

  def index
    render json: Board.where(user_id: current_user.id)
  end

  def show
    render json: @board
  end

  def create
    board = Board.new(user_id: current_user.id)

    if board.save
      render json: board, status: :created, location: api_board_url(board)
    else
      render json: board.errors.full_messages, status: :unprocessable_content
    end
  end

  def destroy
    @board.destroy
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def valid_board_access
    head :forbidden if @board.user_id != current_user.id
  end
end

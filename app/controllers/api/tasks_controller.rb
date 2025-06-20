class Api::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [ :show, :update, :destroy ]
  before_action :validate_task_access!, only: [ :show, :update, :destroy ]
  before_action :validate_edit_board_access!, only: [ :create, :update, :destroy ]
  before_action :validate_view_board_access!, only: [ :index, :show ]

  def index
    tasks = Board.find(params[:board_id]).tasks
    render json: TaskResource.new(tasks).serialize
  end

  def show
    render json: TaskResource.new(@task).serialize
  end

  def create
    task = Task.new(task_params.merge(board_id: params[:board_id]))

    if task.save
      render json: TaskResource.new(task).serialize, status: :created,
             location: api_board_task_url(board_id: params[:board_id], id: task.id)
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_content
    end
  end

  def update
    if @task.update(task_params)
      render json: TaskResource.new(@task).serialize
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_content
    end
  end

  def destroy
    @task.destroy
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def validate_task_access!
    head :forbidden unless @task.board_id == params[:board_id].to_i
  end

  def validate_edit_board_access!
    head :forbidden unless board_owner?
  end

  def validate_view_board_access!
    head :forbidden unless board_owner? || board_member?
  end

  def board_owner?
    Board.find(params[:board_id]).user_id == current_user.id
  end

  def board_member?
    BoardMembership.exists?(board_id: params[:board_id], user_id: current_user.id)
  end
end

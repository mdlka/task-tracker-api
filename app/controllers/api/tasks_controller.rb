class Api::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [ :show, :update, :destroy ]

  def index
    tasks = Board.find(params[:board_id]).tasks
    render json: tasks
  end

  def show
    render json: @task
  end

  def create
    task = Task.new(task_params.merge(board_id: params[:board_id]))

    if task.save
      render json: task, status: :created, location: api_board_task_url(board_id: params[:board_id], id: task.id)
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_content
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
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
end

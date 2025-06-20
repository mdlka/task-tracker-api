class Api::TasksController < ApplicationController
  include BoardAccessible

  before_action :authenticate_user!
  before_action :set_task, only: [ :show, :update, :destroy ]
  before_action :validate_task_access!, only: [ :show, :update, :destroy ]
  before_action :validate_view_board_access!, only: [ :index, :show ]
  before_action :validate_edit_board_access!, only: [ :create, :update, :destroy ]

  def index
    tasks = find_board.tasks
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
    head :forbidden unless @task.belongs_to_board?(params[:board_id])
  end
end

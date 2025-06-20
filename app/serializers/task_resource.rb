class TaskResource
  include Alba::Resource

  attributes :id, :board_id, :title, :description, :status, :created_at, :updated_at
end

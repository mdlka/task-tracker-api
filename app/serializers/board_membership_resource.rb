class BoardMembershipResource
  include Alba::Resource

  attributes :board_id, :user_id, :created_at
end

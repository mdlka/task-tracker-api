module BoardAccessible
  extend ActiveSupport::Concern

  included do
    class_attribute :board_id_param, default: :board_id
  end

  private

  def find_board
    @board ||= Board.find(params[self.board_id_param])
  end

  def validate_edit_board_access!
    head :forbidden unless find_board.owner?(current_user.id)
  end

  def validate_view_board_access!
    head :forbidden unless find_board.owner?(current_user.id) || find_board.member?(current_user.id)
  end
end

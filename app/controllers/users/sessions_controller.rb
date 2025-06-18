class Users::SessionsController < Devise::SessionsController
  include RackSessionsFix

  respond_to :json
end

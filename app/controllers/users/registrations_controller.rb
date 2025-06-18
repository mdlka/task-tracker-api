class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix

  respond_to :json
end

Rails.application.routes.draw do
  devise_for :users, path: "api/auth", path_names: {
      sign_in: "login",
      sign_out: "logout",
      registration: "signup"
    },
    controllers: {
      sessions: "api/users/sessions",
      registrations: "api/users/registrations"
    },
    defaults: { format: :json }

  namespace :api do
    resources :boards, only: [ :index, :show, :create, :destroy ] do
      resources :memberships, only: [ :index, :update, :destroy ], controller: :board_memberships
    end
  end
end

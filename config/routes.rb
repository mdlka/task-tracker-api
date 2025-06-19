Rails.application.routes.draw do
  devise_for :users, path: "auth", path_names: {
      sign_in: "login",
      sign_out: "logout",
      registration: "signup"
    },
    controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    },
    defaults: { format: :json }

  namespace :api do
    resources :boards, only: [ :index, :show, :create, :destroy ]
  end
end

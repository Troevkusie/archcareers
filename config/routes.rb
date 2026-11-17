Rails.application.routes.draw do
  # Health check for Kamal: returns 200 if the app boots without exceptions
  get "up" => "rails/health#show", as: :rails_health_check

  root "landing#index"

  namespace :auth do
    scope :candidate, as: :candidate do
      resource :registration, only: [ :new, :create ], controller: "/candidates/registrations"
      resource :session, only: [ :new, :create, :destroy ], controller: "/candidates/sessions", path: "login"
    end

    scope :employer, as: :employer do
      resource :registration, only: [ :new, :create ], controller: "/employers/registrations"
      resource :session, only: [ :new, :create, :destroy ], controller: "/employers/sessions", path: "login"
    end
  end

  namespace :candidate do
    get "dashboard", to: "dashboard#show"
  end

  namespace :employer do
    get "dashboard", to: "dashboard#show"
  end
end

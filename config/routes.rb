Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resource :webhook, only: [:create]
      resource :event, only: [:create]
    end
  end
end

Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html\
    resources :users
    resources :photos, only: [:index]
    root "photos#index"

    get "/sign_in" => "sessions#new", as: "sign_in_page"
    post "/sign_in" => "sessions#sign_in", as: "sign_in"
    post "/sign_out" => "sessions#sign_out", as: "sign_out"
end

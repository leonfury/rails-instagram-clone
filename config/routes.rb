Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html\
    resources :users 
    resources :users, only: [:show] do
        resources :photos, only: [:new, :create, :show, :edit]
    end

    get "/user/:id/photos" => "photos#index_user", as: "user_photos_index"

    resources :photos, only: [:index, :create]
    root "photos#index"

    get "/sign_in" => "sessions#new", as: "sign_in_page"
    post "/sign_in" => "sessions#sign_in", as: "sign_in"
    post "/sign_out" => "sessions#sign_out", as: "sign_out"
    post "/:id/like" => "likes#create", as: "like"
end

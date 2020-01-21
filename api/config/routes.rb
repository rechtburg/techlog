Rails.application.routes.draw do
  namespace "api" do
    namespace "v1" do
      resources :posts
    end
  end

  devise_for :users
end

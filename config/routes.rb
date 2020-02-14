Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlz
  get "home/" => "home#top"

  resources :animals

end

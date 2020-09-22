# == Route Map
#
#                      Prefix Verb   URI Pattern                                                                              Controller#Action
#         new_account_session GET    /accounts/sign_in(.:format)                                                              devise/sessions#new
#             account_session POST   /accounts/sign_in(.:format)                                                              devise/sessions#create
#     destroy_account_session DELETE /accounts/sign_out(.:format)                                                             devise/sessions#destroy
#        new_account_password GET    /accounts/password/new(.:format)                                                         devise/passwords#new
#       edit_account_password GET    /accounts/password/edit(.:format)                                                        devise/passwords#edit
#            account_password PATCH  /accounts/password(.:format)                                                             devise/passwords#update
#                             PUT    /accounts/password(.:format)                                                             devise/passwords#update
#                             POST   /accounts/password(.:format)                                                             devise/passwords#create
# cancel_account_registration GET    /accounts/cancel(.:format)                                                               devise/registrations#cancel
#    new_account_registration GET    /accounts/sign_up(.:format)                                                              devise/registrations#new
#   edit_account_registration GET    /accounts/edit(.:format)                                                                 devise/registrations#edit
#        account_registration PATCH  /accounts(.:format)                                                                      devise/registrations#update
#                             PUT    /accounts(.:format)                                                                      devise/registrations#update
#                             DELETE /accounts(.:format)                                                                      devise/registrations#destroy
#                             POST   /accounts(.:format)                                                                      devise/registrations#create
#                        home GET    /home(.:format)                                                                          home#top
# animal_image_upload_animals POST   /animals/animal_image_upload(.:format)                                                   animals#animal_image_upload
#        remove_image_animals GET    /animals/remove_image(.:format)                                                          animals#remove_image
#                     animals GET    /animals(.:format)                                                                       animals#index
#                             POST   /animals(.:format)                                                                       animals#create
#                  new_animal GET    /animals/new(.:format)                                                                   animals#new
#                 edit_animal GET    /animals/:id/edit(.:format)                                                              animals#edit
#                      animal GET    /animals/:id(.:format)                                                                   animals#show
#                             PATCH  /animals/:id(.:format)                                                                   animals#update
#                             PUT    /animals/:id(.:format)                                                                   animals#update
#                             DELETE /animals/:id(.:format)                                                                   animals#destroy
#             my_animal_books GET    /my_animal_books(.:format)                                                               my_animal_books#index
#                             POST   /my_animal_books(.:format)                                                               my_animal_books#create
#          new_my_animal_book GET    /my_animal_books/new(.:format)                                                           my_animal_books#new
#         edit_my_animal_book GET    /my_animal_books/:id/edit(.:format)                                                      my_animal_books#edit
#              my_animal_book GET    /my_animal_books/:id(.:format)                                                           my_animal_books#show
#                             PATCH  /my_animal_books/:id(.:format)                                                           my_animal_books#update
#                             PUT    /my_animal_books/:id(.:format)                                                           my_animal_books#update
#                             DELETE /my_animal_books/:id(.:format)                                                           my_animal_books#destroy
#          rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#   rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#          rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#   update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#        rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlz

Rails.application.routes.draw do
  devise_for :accounts, :controllers => {
    :registrations => 'accounts/registrations',
    :sessions => 'accounts/sessions',
  }

  get "ex/ex_sign_in" => "ex#ex_sign_in"
  post "ex/ex_create" => "ex#ex_create"
  get "ex/good_luck" => "ex#good_luck"
  patch "ex/on_timepass" => "ex#on_timepass"
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root to: "home#top"
  get "home/explanation" => "home#explanation"
  get "home/privacy" => "home#privacy"
  get "home/terms_of_service" => "home#terms_of_service"

  resources :animals do
    collection do
      post "animal_image_upload" => "animals#animal_image_upload"
      get "remove_image" => "animals#remove_image"
    end
  end

  resources :my_animal_books

  get "my_page/" => "my_page#index"
  get "my_page/edit" => "my_page#edit"
  get "my_page/email_edit" => "my_page#email_edit"
  post "my_page/update" => "my_page#update"
  post "my_page/account_image_upload" => "my_page#account_image_upload"
  get "my_page/remove_image" => "my_page#remove_image"

end

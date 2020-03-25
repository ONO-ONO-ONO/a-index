# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#                      home GET    /home(.:format)                                                                          home#top
#                   animals GET    /animals(.:format)                                                                       animals#index
#                           POST   /animals(.:format)                                                                       animals#create
#                new_animal GET    /animals/new(.:format)                                                                   animals#new
#               edit_animal GET    /animals/:id/edit(.:format)                                                              animals#edit
#                    animal GET    /animals/:id(.:format)                                                                   animals#show
#                           PATCH  /animals/:id(.:format)                                                                   animals#update
#                           PUT    /animals/:id(.:format)                                                                   animals#update
#                           DELETE /animals/:id(.:format)                                                                   animals#destroy
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create


# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlz

Rails.application.routes.draw do
  devise_for :accounts

  get "home/" => "home#top"

  resources :animals do
    collection do
      post "animal_image_upload" => "animals#animal_image_upload"
      get "remove_image" => "animals#remove_image"
    end
  end

end

class AccountImage < ApplicationRecord
  belongs_to :account

  mount_uploader :file, AccountImageUploader
end

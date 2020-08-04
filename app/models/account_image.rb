# == Schema Information
#
# Table name: account_images
#
#  id         :bigint           not null, primary key
#  avatar     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :integer
#
class AccountImage < ApplicationRecord
  belongs_to :account

  mount_uploader :file, AccountImageUploader
end

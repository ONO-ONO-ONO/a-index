# == Schema Information
#
# Table name: animal_images
#
#  id         :bigint           not null, primary key
#  image      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  animal_id  :integer
#
class AnimalImage < ApplicationRecord
  belongs_to :animal

  mount_uploader :image, AnimalImageUploader
end

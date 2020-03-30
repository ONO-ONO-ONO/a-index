# == Schema Information
#
# Table name: my_animal_books
#
#  id               :bigint           not null, primary key
#  check            :integer          default("0"), not null
#  my_animal_detail :text(65535)
#  my_animal_image  :string(255)      not null
#  my_animal_name   :string(255)      not null
#  my_animal_place  :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer          not null
#
class MyAnimalBook < ApplicationRecord
  mount_uploader :my_animal_image, MyAnimalImageUploader
end

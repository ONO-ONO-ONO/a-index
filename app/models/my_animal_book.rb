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

  validates :my_animal_name, presence: true, length: { maximum: 30 }
  validates :my_animal_place, presence: true, length: { maximum: 20 }
  validates :my_animal_image, presence: true,
                              file_size: { less_than_or_equal_to: 5115.kilobytes,  message: 'は %{count}以下である必要があります。'},
                              file_content_type: { allow: ['image/jpeg', 'image/png'],  message: 'はJPEGとPNGのみを許可します'}

  # file_size: と　file_content_type:　についてはgem 'file_validators'を使用。詳細 → https://github.com/musaffa/file_validators
  # gem 'file_validators'で増えたバリテーション内容はmodel.ja.ymlにエラーメッセージを書いても反映されないので、modelに直接記載する。
end

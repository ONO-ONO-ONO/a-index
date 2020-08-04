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

  # file_size: と　file_content_type:　についてはgem 'file_validators'を使用。詳細 → https://github.com/musaffa/file_validators
  # gem 'file_validators'で増えたバリテーション内容はmodel.ja.ymlにエラーメッセージを書いても反映されないので、modelに直接記載する。
  validates :image, presence: true,
                    file_size: { less_than_or_equal_to: 5115.kilobytes,  message: 'は %{count}以下である必要があります。'},
                    file_content_type: { allow: ['image/jpeg', 'image/png'],  message: 'はJPEGとPNGのみを許可します'}

end

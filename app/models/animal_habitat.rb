# == Schema Information
#
# Table name: animal_habitats
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  habitat    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  animal_id  :integer
#
class AnimalHabitat < ApplicationRecord
  # belongs_to :animal

  # validates :habitat, length: { maximum: 15 }

  # 【このテーブルは現状使用することが無くなった。(他の使い道を考え中。無ければ削除予定)】
end

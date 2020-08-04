# == Schema Information
#
# Table name: animal_distributions
#
#  id             :bigint           not null, primary key
#  deleted_at     :datetime
#  distribution_1 :string(255)
#  distribution_2 :string(255)
#  distribution_3 :string(255)
#  distribution_4 :string(255)
#  distribution_5 :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  animal_id      :integer
#
class AnimalDistribution < ApplicationRecord
  # belongs_to :animal

  # validates :distribution, length: { maximum: 15 }

  # 【このテーブルは現状使用することが無くなった。(他の使い道を考え中。無ければ削除予定)】
end

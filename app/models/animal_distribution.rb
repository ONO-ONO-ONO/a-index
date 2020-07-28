# == Schema Information
#
# Table name: animal_distributions
#
#  id           :bigint           not null, primary key
#  deleted_at   :datetime
#  distribution :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  animal_id    :integer
#
class AnimalDistribution < ApplicationRecord
  belongs_to :animal

  validates :distribution, length: { maximum: 15 }
end

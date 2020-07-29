# == Schema Information
#
# Table name: animals
#
#  id                 :bigint           not null, primary key
#  animal_class       :string(255)
#  animal_family      :string(255)
#  animal_genus       :string(255)
#  animal_order       :string(255)
#  animal_species     :string(255)
#  animal_sub_species :string(255)
#  binomial_name      :string(255)
#  classification     :string(255)
#  created_user       :integer
#  deleted_at         :datetime
#  detail             :text(65535)
#  max_length         :float(24)
#  max_weight         :float(24)
#  min_length         :float(24)
#  min_weight         :float(24)
#  name               :string(255)      not null
#  red_list           :string(255)
#  updated_user       :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Animal < ApplicationRecord
  has_one :animal_distribution, dependent: :destroy
  has_one :animal_habitat,      dependent: :destroy
  has_one :animal_image,        dependent: :destroy
  accepts_nested_attributes_for :animal_distribution
  accepts_nested_attributes_for :animal_habitat
  accepts_nested_attributes_for :animal_image

  validates :name, presence: true, length: { maximum: 30 }
  validates :binomial_name, length: { maximum: 60 }
  validates :classification, length: { maximum: 6 }
  validates :animal_class, length: { maximum: 6 }
  validates :animal_order, length: { maximum: 30 }
  validates :animal_family, length: { maximum: 30 }
  validates :animal_genus, length: { maximum: 30 }
  validates :animal_species, length: { maximum: 30 }
  validates :animal_sub_species, length: { maximum: 30 }
  validates :min_length, length: { maximum: 8 }, numericality: true, allow_blank: true
  validates :max_length, length: { maximum: 8 }, numericality: true, allow_blank: true
  validates :min_weight, length: { maximum: 8 }, numericality: true, allow_blank: true
  validates :max_weight, length: { maximum: 8 }, numericality: true, allow_blank: true
  validates :red_list, length: { maximum: 2 }

end

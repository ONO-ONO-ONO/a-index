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

end

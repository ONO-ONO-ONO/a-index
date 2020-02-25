class Animal < ApplicationRecord
  has_one :animal_distribution
  has_one :animal_habitat
  accepts_nested_attributes_for :animal_distribution
  accepts_nested_attributes_for :animal_habitat

end

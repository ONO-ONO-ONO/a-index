# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  role_name  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role_id    :integer
#
class Role < ApplicationRecord
  belongs_to :accounts

  def set_role
    self.role_name = Role.find(self.role) if self.role.present?
  end
end

# == Schema Information
#
# Table name: accounts
#
#  id                     :bigint           not null, primary key
#  account_name           :string(255)      default(""), not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  role                   :integer          default("0"), not null
#  sign_in_count          :integer          default("0"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_accounts_on_email                 (email) UNIQUE
#  index_accounts_on_reset_password_token  (reset_password_token) UNIQUE
#
class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :account_image,        dependent: :destroy
  accepts_nested_attributes_for :account_image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :account_name, presence: true, length: { maximum: 10 }
  validates :email, presence: true, length: { maximum: 30 }

end

# == Schema Information
#
# Table name: accounts
#
#  id                     :bigint           not null, primary key
#  account_name           :string(255)      default(""), not null
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  role                   :integer          default("0"), not null
#  sign_in_count          :integer          default("0"), not null
#  unconfirmed_email      :string(255)
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
         # letter_opener回りの設定が終わったら以下コメントアウト部分を実装、上の行の:recoverable, :rememberable, :validatableを削除予定
        #  :recoverable, :rememberable, :trackable, :validatable,
        #  :confirmable

  # 一時的にaccount_nameのバリテーションをオフにする。devise回りを修正出来たら復活
  validates :account_name, presence: true, length: { maximum: 10 }, uniqueness: true
  validates :email, length: { maximum: 30 }

  def email_required?
    !email.blank? && super
  end

  # 役職名を取得
  def role_name
    return Role.find_by(role_id: self.role).role_name
  end

  # ログインアカウントのMy動物図鑑の登録数
  def my_animal_books_count
    return MyAnimalBook.where(user_id: self.id).count
  end
  
end

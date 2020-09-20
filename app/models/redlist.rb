# == Schema Information
#
# Table name: redlists
#
#  id                 :bigint           not null, primary key
#  red_list_details   :string(255)      not null
#  red_list_full_name :string(255)
#  red_list_name      :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Redlist < ApplicationRecord
end

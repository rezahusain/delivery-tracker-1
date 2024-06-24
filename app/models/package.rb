# == Schema Information
#
# Table name: packages
#
#  id          :integer          not null, primary key
#  arrives_on  :date
#  description :string
#  details     :text
#  is_received :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class Package < ApplicationRecord
  validates(:arrives_on, {:presence=>true})
  validates(:description, {:presence=>true})
  validates(:details, {:presence=>true})
end

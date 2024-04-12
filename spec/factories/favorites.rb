# == Schema Information
#
# Table name: favorites
#
#  id               :bigint           not null, primary key
#  favoritable_type :string
#  favoritable_id   :bigint
#  user_id          :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_favorites_on_favoritable  (favoritable_type,favoritable_id)
#  index_favorites_on_user_id      (user_id)
#
FactoryBot.define do
  factory :favorite do
    
  end
end

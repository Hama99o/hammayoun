# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  include PgSearch::Model
  acts_as_favoritable
  acts_as_favoritor

  pg_search_scope :search_tags,
                  against: [:name],
                  using: {
                   tsearch: { prefix: true
                  }
  }
end

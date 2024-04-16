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
class TagSerializer < ApplicationSerializer
  identifier :id
  fields :name, :created_at
end

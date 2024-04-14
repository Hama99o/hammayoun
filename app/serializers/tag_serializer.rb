class TagSerializer < ApplicationSerializer
  identifier :id
  fields :name, :created_at
end
# == Schema Information
#
# Table name: email_records
#
#  id             :bigint           not null, primary key
#  email          :string
#  shareable_type :string
#  shareable_id   :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_email_records_on_shareable  (shareable_type,shareable_id)
#  index_email_records_unique        (email,shareable_type,shareable_id) UNIQUE
#
class EmailRecord < ApplicationRecord
  belongs_to :shareable, polymorphic: true

    # # Custom attribute setter for shareable
    # def shareable=(object)
    #   self.shareable_type = object.class.name
    #   self.shareable_id = object.id
    # end
end

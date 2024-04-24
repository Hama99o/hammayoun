# == Schema Information
#
# Table name: email_records
#
#  id              :bigint           not null, primary key
#  email           :string
#  shareable_type  :string
#  shareable_id    :bigint
#  additional_info :jsonb
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_email_records_on_shareable  (shareable_type,shareable_id)
#  index_email_records_unique        (email,shareable_type,shareable_id) UNIQUE
#
FactoryBot.define do
  factory :email_record do
    email { "MyString" }
    model_name { "MyString" }
    record_id { "" }
    additional_info { "" }
  end
end
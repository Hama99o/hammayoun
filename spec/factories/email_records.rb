# == Schema Information
#
# Table name: email_records
#
#  id          :bigint           not null, primary key
#  email       :string
#  record_type :string
#  record_id   :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_email_records_on_email_and_record_type_and_record_id  (email,record_type,record_id) UNIQUE
#  index_email_records_on_record                               (record_type,record_id)
#
FactoryBot.define do
  factory :email_record do
    email { "MyString" }
    model_name { "MyString" }
    record_id { "" }
    additional_info { "" }
  end
end

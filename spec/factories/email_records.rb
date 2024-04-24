# == Schema Information
#
# Table name: email_records
#
#  id              :bigint           not null, primary key
#  email           :string
#  model_name      :string
#  record_id       :bigint
#  additional_info :jsonb
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_email_records_on_email_and_model_name_and_record_id  (email,model_name,record_id) UNIQUE
#
FactoryBot.define do
  factory :email_record do
    email { "MyString" }
    model_name { "MyString" }
    record_id { "" }
    additional_info { "" }
  end
end

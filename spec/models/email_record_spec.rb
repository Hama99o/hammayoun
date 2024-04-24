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
require 'rails_helper'

RSpec.describe EmailRecord, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

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
class EmailRecord < ApplicationRecord

  # Method to find the associated record
  def associated_record
    # Get the class name from the model_name attribute and convert it to a class constant
    model_class = model_name.constantize

    # Find the record in the associated model
    record = model_class.find(record_id)

    return record
  rescue NameError, ActiveRecord::RecordNotFound
    # Handle if the model class or record is not found
    return nil
  end
end

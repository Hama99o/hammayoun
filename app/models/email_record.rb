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

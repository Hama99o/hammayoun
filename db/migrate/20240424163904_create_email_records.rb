class CreateEmailRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :email_records do |t|
      t.string :email
      t.string :model_name
      t.bigint :record_id
      t.jsonb :additional_info, default: {}

      t.timestamps
    end

    add_index :email_records, [:email, :model_name, :record_id], unique: true
  end
end

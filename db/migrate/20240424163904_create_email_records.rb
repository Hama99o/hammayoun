class CreateEmailRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :email_records do |t|
      t.string :email
      t.references :record, polymorphic: true, index: true

      t.timestamps
    end

    add_index :email_records, [:email, :record_type, :record_id], unique: true
  end
end

class CreateNoteAppNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :note_app_notes do |t|
      t.references :owner, foreign_key: { to_table: :users }
      t.jsonb :data
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end

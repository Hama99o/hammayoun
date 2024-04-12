# == Schema Information
#
# Table name: note_app_notes
#
#  id          :bigint           not null, primary key
#  owner_id    :bigint
#  status      :integer          default(0), not null
#  data        :jsonb
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_note_app_notes_on_owner_id  (owner_id)
#
class NoteApp::Note < ApplicationRecord
  belongs_to :owner, class_name: "User"

  enum status: {
    trashed: 0,
    published: 1
  }

  include PgSearch::Model

  pg_search_scope :search_notes,
                  against: [:title, :description, :data],
                  associated_against: {
                    owner: %i[lastname firstname]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
end

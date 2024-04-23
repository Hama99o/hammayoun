# == Schema Information
#
# Table name: note_app_notes
#
#  id          :bigint           not null, primary key
#  owner_id    :bigint
#  status      :integer          default("trashed"), not null
#  data        :jsonb
#  title       :string
#  description :text
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_note_app_notes_on_owner_id  (owner_id)
#
class NoteApp::Note < ApplicationRecord
  belongs_to :owner, class_name: "User"
  before_destroy :delete_note_relations

  acts_as_favoritable
  acts_as_favoritor

  enum status: {
    trashed: 0,
    published: 1
  }

  include PgSearch::Model

  store_accessor :data,
                 :job_id,
                 :repeat_frequency,
                 :launch_time,
                 :launch_date

  pg_search_scope :search_notes,
                  against: [:title, :description, :data],
                  associated_against: {
                    owner: %i[lastname firstname]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
  def tags
    NoteApp::Tag.where(id: favorites.where(scope: :note_tag).pluck(:favoritable_id))
  end

  def delete_note_relations
    Favorite.where(
      favoritor_type: "NoteApp::Note",
      scope: :note_tag
    ).destroy_all
  end
end

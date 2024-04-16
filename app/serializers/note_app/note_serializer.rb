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
class NoteApp::NoteSerializer < ApplicationSerializer
  identifier :id

  fields :title, :description, :data, :status, :created_at

  field :is_shared do |note, options|
    current_user = options[:current_user]
    next unless current_user.present?
    note.favorited.where(favoritor_id: current_user.id).present?
  end

  field :role do |note, options|
    current_user = options[:current_user]
    next unless current_user.present?
    if current_user == note.owner
      :owner
    else
      note.favorited.find_by(favoritor_id: current_user.id, scope: :favorite_note).role
    end
  end

  field :shared_users do |note, options|
    users = User.where(id: note.favorited.where(scope: :favorite_note).pluck(:favoritor_id))
    next [] unless users.present?
    UserSerializer.render_as_hash(users)
  end

  field :shared_count do |note, options|
    User.where(id: note.favorited.where(scope: :favorite_note).pluck(:favoritor_id)).count
  end

  field :tags do |note, options|
    TagSerializer.render_as_hash(note.tags)
  end

  field :tag_ids do |note, options|
    note.tags.ids
  end

  association :owner, blueprint: UserSerializer
end

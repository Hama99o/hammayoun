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
FactoryBot.define do
  factory :note_app_note, class: 'NoteApp::Note' do
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph }
    status { :published }
    association :owner, factory: :user
  end
end

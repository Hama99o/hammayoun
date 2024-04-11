# == Schema Information
#
# Table name: note_app_shares
#
#  id                  :bigint           not null, primary key
#  note_id             :bigint
#  shared_with_user_id :bigint
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_note_app_shares_on_note_id              (note_id)
#  index_note_app_shares_on_shared_with_user_id  (shared_with_user_id)
#
class NoteApp::Share < ApplicationRecord
end

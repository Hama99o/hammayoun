class Api::V1::NoteApp::NotesController < ApplicationController

  def index
    paginate_render(
      NoteApp::NoteSerializer,
      policy_scope(current_user.notes.where(status: :published).order(created_at: :desc)))

  end
end
class Api::V1::NoteApp::NotesController < ApplicationController

  before_action :note, only: [:show, :update, :destroy]
  before_action :notes, only: [:index]

  def index
    @notes = @notes.search_notes(params[:search]) if params[:search].present?

    paginate_render(
      NoteApp::NoteSerializer,
      policy_scope(@notes),
      extra: { root: :notes }
    )
  end

  def show
    render json: {
      note: NoteApp::NoteSerializer.render_as_json(authorize(@note))
    }, status: :ok
  end

  def update
    if @note.update(**note_params)
      render json: { note: NoteApp::NoteSerializer.render_as_hash(authorize(@note)) }, status: :ok
    else
      render json: @note.errors.messages, status: :unprocessable_entity
    end
  end

  def create
    note = current_user.notes.create(status: :published, **note_params)

    if note
      render json: {
        note: NoteApp::NoteSerializer.render_as_json(authorize(note))
      }
    else
      render json: note.errors.messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @note.delete
      render json: { note: authorize(@note) }, status: :ok
    else
      render json: @note.errors.messages, status: :unprocessable_entity
    end
  end

  private

  def note
    @note = NoteApp::Note.find(params.require(:id))
  end

  def notes
    @notes ||= current_user.all_notes.where(status: :published).order(created_at: :desc)
  end

  def note_params
    params.permit(
      :title,
      :description,
      :data,
      :status
    )
  end
end
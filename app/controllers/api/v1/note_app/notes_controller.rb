class Api::V1::NoteApp::NotesController < ApplicationController

  before_action :note, only: [:show, :update, :destroy]
  before_action :notes, only: [:index]

  def index
    @notes = @notes.search_notes(params[:search]) if params[:search].present?

    paginate_render(
      NoteApp::NoteSerializer,
      policy_scope(@notes),
      extra: {
        root: :notes,
        current_user: current_user
      }
    )
  end

  def show
    render json: {
      note: NoteApp::NoteSerializer.render_as_json(authorize(@note), current_user: current_user)
    }, status: :ok
  end

  def tags
    tags = NoteApp::Tag.all
    p tags
    paginate_render(
      TagSerializer,
      tags,
      extra: {
        root: :tags,
        current_user: current_user
      }
    )
  end

  def invite_user_toggle
    email = params.require(:email)
    user_action = params.require(:user_action)
    role = params.require(:role)
    note_id = params.require(:note_id)

    user = User.find_by(email: email)
    return render json: { error: 'User not found' }, status: :not_found unless user

    note = authorize(NoteApp::Note.find(note_id))

    return render json: { error: 'User is already the owner' }, status: :not_found if user == note.owner
    return render json: { error: 'User is already invited' }, status: :not_found if user.favorites.where(favoritable_id: note_id, scope: :favorite_note).present?

    if user_action == 'add'
      if user.favorite_with_role(note, scope: :favorite_note, role: role)
        render json: { note: NoteApp::NoteSerializer.render_as_json(note, current_user: current_user) }, status: :ok
      else
        render json: { error: "Failed to add user" }, status: :unprocessable_entity
      end
    elsif user_action == 'remove'
      user.unfavorite(note, scope: :favorite_note)
      render json: { note: NoteApp::NoteSerializer.render_as_json(note, current_user: current_user) }, status: :ok
    else
      render json: { error: "Invalid action: #{user_action}" }, status: :unprocessable_entity
    end
  end

  def update
    if @note.update(**note_params)
      render json: { note: NoteApp::NoteSerializer.render_as_hash(authorize(@note), current_user: current_user) }, status: :ok
    else
      render json: @note.errors.messages, status: :unprocessable_entity
    end
  end

  def create
    note = current_user.notes.create(status: :published, **note_params)

    if note
      render json: {
        note: NoteApp::NoteSerializer.render_as_json(authorize(note), current_user: current_user)
      }
    else
      render json: note.errors.messages, status: :unprocessable_entity
    end
  end

  def destroy
    if authorize(@note).delete
      render json: { note: @note }, status: :ok
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
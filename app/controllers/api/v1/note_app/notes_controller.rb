class Api::V1::NoteApp::NotesController < ApplicationController

  before_action :note, only: [:show, :update, :destroy, :restore, :destroy_permanently, :reminder]

  def index
    note_index(:published)
  end

  def trashes
    note_index(:trashed)
  end

  def show
    render json: {
      note: NoteApp::NoteSerializer.render_as_json(authorize(@note), current_user: current_user)
    }, status: :ok
  end

  def set_reminder
    note = Note.find(params[:id])
    reminder_date_time = DateTime.parse(params[:reminder_date_time])

    if reminder_date_time && NoteReminderWorker.perform_at(reminder_date_time, @note.id)
      render json: { message: "Reminder set successfully" }, status: :ok
    else
      render json: { error: "Failed to set reminder" }, status: :unprocessable_entity
    end
  end

  def tags
    tags = NoteApp::Tag.all
    tags = tags.search_tags(params[:search]) if params[:search].present?

    paginate_render(
      TagSerializer,
      tags,
      per_page: 50,
      extra: {
        root: :tags,
        current_user: current_user
      }
    )
  end

  def create_and_assign_tag
    note = NoteApp::Note.find(params[:note_id])
    tag = NoteApp::Tag.create(name: params[:text])
    if note.favorite(tag, scope: :note_tag)
      render json: {
        tag: TagSerializer.render_as_json(tag, current_user: current_user)
      }, status: :ok
    else
      render json: { error: "Failed to create and assign tag" }, status: :unprocessable_entity
    end
  end

  def toggle_tag
    tag = NoteApp::Tag.find(params[:tag_id])
    note = NoteApp::Note.find(params[:note_id])

    if note.favorited?(tag, scope:  :note_tag)
      note.unfavorite(tag, scope: :note_tag)
    else
      note.favorite(tag, scope: :note_tag)
    end

    render json: {
      tag: TagSerializer.render_as_json(tag, current_user: current_user)
    }, status: :ok
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
      render_unprocessable_entity(@note)
    end
  end

  def create
    note = current_user.notes.create(status: :published, **note_params)

    if note
      render json: {
        note: NoteApp::NoteSerializer.render_as_json(authorize(note), current_user: current_user)
      }
    else
      render_unprocessable_entity(note)
    end
  end

  def destroy_permanently
    if authorize(@note).delete
      render json: { note: @note }, status: :ok
    else
      render_unprocessable_entity(@note)
    end
  end

  def restore
    if authorize(@note).update(status: :published, deleted_at: nil)
      render json: @note
    else
      render_unprocessable_entity(@note)
    end
  end

  def destroy
    if authorize(@note).update(status: :trashed, deleted_at: Time.now)

      render json: @note
    else
      render_unprocessable_entity(@note)
    end
  end

  private

  def note
    @note = NoteApp::Note.find(params.require(:id))
  end

  def note_index(status)
    notes = current_user.all_notes.where(status:)
    notes = notes.search_notes(params[:search]) if params[:search].present?

    paginate_render(
      NoteApp::NoteSerializer,
      policy_scope(notes.order(created_at: :desc)),
      extra: {
        root: :notes,
        current_user: current_user
      }
    )
  end

  def notes
    current_user.all_notes
  end

  def note_params
    params.permit(
      :title,
      :description,
      :data
    )
  end
end
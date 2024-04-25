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

    if reminder_date_time && NoteReminderWorker.perform_at(reminder_date_time, @note.id, current_user.id)
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
    
    if Tagging.create(tag:, taggable: note)
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

    if Tagging.find_by(tag:, taggable: note).present?
      Tagging.find_by(tag:, taggable: note)&.destroy
    else
      Tagging.create(tag:, taggable: note)
    end

    render json: {
      tag: TagSerializer.render_as_json(tag, current_user: current_user)
    }, status: :ok
  end

  def share_with_user_toggle
    email = params.require(:email)
    user_action = params.require(:user_action)
    role = params.require(:role)
    note_id = params.require(:note_id)

    user = User.find_by(email: email)
    note = authorize(NoteApp::Note.find(note_id))


    if user_action == 'add'
      if user.nil?
        EmailRecord.find_or_create_by(
          email:,
          shareable: note,
          additional_info: {
            role:
          }
        )
        NoteMailer.share_note(note, email).deliver_now
        render json: { note: NoteApp::NoteSerializer.render_as_json(note, current_user: current_user) }, status: :ok
      else
        return render json: { error: 'User is already the owner' }, status: :not_found if user == note.owner
        return render json: { error: 'User is already invited' }, status: :not_found if note.shared_with_users.where(id: user.id).present?

        if NoteApp::Share.create(shared_with_user: user, note:, role:)
          NoteMailer.share_note(note, email)

          render json: { note: NoteApp::NoteSerializer.render_as_json(note, current_user: current_user) }, status: :ok
        else
          render json: { error: "Failed to add user" }, status: :unprocessable_entity
        end
      end

    elsif user_action == 'remove'
      NoteApp::Share.find_by(shared_with_user: user, note:)&.destroy
      render json: { note: NoteApp::NoteSerializer.render_as_json(note, current_user: current_user) }, status: :ok
    else
      render json: { error: "Invalid action: #{user_action}" }, status: :unprocessable_entity
    end
  end

  def update
    if authorize(@note).update(**note_params)
      render json: { note: NoteApp::NoteSerializer.render_as_hash(@note, current_user: current_user) }, status: :ok
    else
      render_unprocessable_entity(@note)
    end
  end

  def create
    authorize(NoteApp::Note)
    note = current_user.notes.create(status: :published, **note_params)

    if note
      render json: {
        note: NoteApp::NoteSerializer.render_as_json(note, current_user: current_user)
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
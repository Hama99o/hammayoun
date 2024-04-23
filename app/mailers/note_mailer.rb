class NoteMailer < ApplicationMailer
  def share_note(note, recipient_email)
    @note = note
    @recipient_email = recipient_email
    mail(to: @recipient_email, subject: "You've received a shared note")
  end

  def send_reminder(note, user)
    @note = note
    @user = user

    mail(to: @user.email, subject: "Reminder: #{@note.title}")
  end
end

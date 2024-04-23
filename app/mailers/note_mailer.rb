class NoteMailer < ApplicationMailer
  def share_note(note, recipient_email)
    @note = note
    @recipient_email = recipient_email
    mail(to: @recipient_email, subject: "You've received a shared note")
  end
end

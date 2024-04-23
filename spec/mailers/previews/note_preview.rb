# Preview all emails at http://localhost:3000/rails/mailers/note
class NotePreview < ActionMailer::Preview
  def share_note
    NoteMailer.share_note(NoteApp::Note.last, "hmmshl@gmail.com")
  end
end

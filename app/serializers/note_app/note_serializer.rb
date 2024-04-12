class NoteApp::NoteSerializer < ApplicationSerializer
  identifier :id

  fields :title, :description, :data, :created_at

  association :owner, blueprint: UserSerializer

end
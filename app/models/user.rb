# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  tokens                 :jsonb
#  firstname              :string           default(""), not null
#  lastname               :string           default(""), not null
#  birth_date             :date
#  join_date              :date
#  authentication_token   :string
#  phone_number           :string           default(""), not null
#  gender                 :string           default(""), not null
#  job_title              :string           default(""), not null
#  linkedin               :string           default(""), not null
#  access_level           :integer          default("employee"), not null
#  status                 :integer          default("active"), not null
#  timezone               :string           default("Europe/Paris")
#  lang                   :string           default("en")
#  locked_at              :datetime
#  strikes_count          :integer          default(0)
#  agreed_to_terms        :boolean
#  applications           :jsonb
#  current_application    :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  has_many :shares, class_name: 'NoteApp::Share', foreign_key: 'shared_with_user_id', dependent: :destroy
  has_many :shared_notes, through: :shares, source: :note, class_name: 'NoteApp::Note', foreign_key: 'note_id'

  include Devise::JWT::RevocationStrategies::Allowlist
  include Rails.application.routes.url_helpers

  acts_as_favoritor
  has_many :notes, class_name: "NoteApp::Note", foreign_key: :owner_id, dependent: :nullify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  include PgSearch::Model

  pg_search_scope :search_users,
                  against: [:firstname, :lastname, :email],
                  using: {
                    tsearch: { prefix: true }
                  }

  validates :email, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true

  has_one_attached :photo

  enum access_level: {
    employee: 0,
    admin: 1,
    super_admin: 2
  }

  enum status: {
    inactive: 0,
    active: 1
  }

  def fullname
    "#{firstname&.titleize} #{lastname&.upcase}"
  end

  def all_notes
    NoteApp::Note.where(
      id: shared_notes.ids + notes.ids
    )
  end

  def admin_or_above?
    %i[admin super_admin].include? access_level.to_sym
  end

  def get_photo_url
    url_for(photo).presence
  end

  def get_photo_urls
    if photo.representable?
      {
        "30" => Rails.application.routes.url_helpers.rails_blob_url(photo.variant(resize: "30")),
        "50" => Rails.application.routes.url_helpers.rails_blob_url(photo.variant(resize: "50")),
        "70" => Rails.application.routes.url_helpers.rails_blob_url(photo.variant(resize: "70")),
        "100" => Rails.application.routes.url_helpers.rails_blob_url(photo.variant(resize: "100")),
        "150" => Rails.application.routes.url_helpers.rails_blob_url(photo.variant(resize: "150"))
      }
    end
  end

  def reset_password!
    tokens.shift until tokens.empty? if tokens.present?
    send(:set_reset_password_token)

    UserMailer.reset_password(self).deliver_later
  end
end

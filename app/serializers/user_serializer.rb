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
#  status                 :integer
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
class UserSerializer < ApplicationSerializer
  identifier :id
  fields :email, :access_level, :lang, :status, :birth_date

  field :fullname do |object|
    object.fullname.presence
  end

  field :firstname do |user|
    user.firstname.presence
  end

  field :lastname do |user|
    user.lastname.presence
  end

  field :email do |user|
    user.email.presence
  end

  field :avatar do |object|
    object.get_photo_url.presence if object.photo.attached?
  end
end

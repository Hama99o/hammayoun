# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if resource.persisted?
        # Call mailer to send welcome email
        UserMailer.welcome_email(resource).deliver_now
      end
    end
  end

  private

  def respond_with(resource, _opts = {})
    render(json: UserSerializer.render_as_hash(resource)) && return if resource.persisted?

    render json: { messages: resource.errors.full_messages }
  end

  def sign_up_params
    params.require(:user).permit(:firstname, :lastname, :birth_date, :email, :password, :agreed_to_terms)
  end
end

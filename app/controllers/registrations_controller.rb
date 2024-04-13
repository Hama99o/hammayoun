# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  private

  def respond_with(resource, _opts = {})
    render(json: UserSerializer.render_as_hash(resource)) && return if resource.persisted?

    render json: { messages: resource.errors.full_messages }
  end

  def sign_up_params
    params.require(:user).permit(:firstname, :lastname, :birth_date, :email, :password, :agreed_to_terms)
  end
end

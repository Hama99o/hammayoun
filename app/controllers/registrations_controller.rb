# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  private

  def respond_with(resource, _opts = {})
    register_success(resource) && return if resource.persisted?

    register_failed(resource)
  end

  def register_success(resource)
    render jsonapi: resource
  end

  def register_failed(resource)
    render jsonapi_errors: resource.errors, status: :bad_request
  end

  def sign_up_params
    params.require(:user).permit(:firstname, :lastname, :birth_date, :email, :password, :agreed_to_terms)
  end

end

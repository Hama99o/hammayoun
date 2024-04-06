class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  include Pagy::Backend

  after_action { pagy_headers_merge(@pagy) if @pagy }

  def unconnected_user
    render template: 'layouts/unconnected_user'
  end

  def connected_user
    return redirect_to unconnected_user_path unless user_signed_in?

    render template: 'layouts/connected_user'
  end
end

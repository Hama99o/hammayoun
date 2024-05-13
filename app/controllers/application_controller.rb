class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # before_action :set_timezone
  skip_before_action :authenticate_user!, only: [:multi_magic]
  skip_before_action :verify_authenticity_token ## this action is temporary
  include Pagy::Backend
  include Pundit::Authorization

  after_action { pagy_headers_merge(@pagy) if @pagy }

  rescue_from ActionController::BadRequest do |e|
    render json: { message: e.to_s }, status: :bad_request
  end
  rescue_from OpenURI::HTTPError do |e|
    render json: { message: e.to_s }, status: :bad_request
  end
  rescue_from ActionController::ParameterMissing do |e|
    render json: { message: e.to_s }, status: :unprocessable_entity
  end
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.to_s }, status: :not_found
  end
  rescue_from Pundit::NotAuthorizedError do |e|
    render json: { message: e.to_s }, status: :forbidden
  end
  rescue_from ActiveSupport::MessageVerifier::InvalidSignature do |e|
    render json: { message: "File is not valid" }, status: :unprocessable_entity
  end

  def render_unprocessable_entity(entity)
    render json: { message: entity.is_a?(Array) ? entity : entity.errors.full_messages },
           status: :unprocessable_entity
  end

  def multi_magic
    # return redirect_to multi_magic unless user_signed_in?
    # headers = request.headers
    # headers.each do |key, value|
    #   puts "#{key}: #{value}"
    #   p 'byeeeeeeeeeeeeeeeeeeeeeeeeeee'
    # end
    render template: 'layouts/multi_magic'
  end

  def paginate_render(serializer_const, list, page: 1, per_page: 10, root: list&.table_name, meta: {}, extra: {})
    @pagy, @records = pagy(list, items: per_page)

    render json: serializer_const.render(
      @records,
      root:,
      meta: {
        **meta,
        pagy: pagy_metadata(@pagy),
        total_count: list.count
      },
      **extra
    ),
      status: :ok
  end
end

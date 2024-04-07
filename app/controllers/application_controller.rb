class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  include Pagy::Backend
  include Pundit::Authorization

  after_action { pagy_headers_merge(@pagy) if @pagy }


  def multi_magic
    # return redirect_to multi_magic unless user_signed_in?

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

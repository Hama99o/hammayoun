class Api::V1::UsersController < ApplicationController
  # include Pagy::Backend
  # before_action :authenticate_user!, except: [:reset_password]

  before_action :user, only: [:show, :update, :destroy]
  before_action :users, only: [:index, :activated_users]
  skip_before_action :authenticate_user!, only: [:reset_password, :reset_password_confirmation]

  def index
    @users = @users
    @users = @users.search_users(params[:search]) if params[:search].present?
    paginate_render(UserSerializer,policy_scope(@users))

  end

  def show
    render json: {
      user: UserSerializer.render_as_json(authorize(@user))
    }, status: :ok
  end

  def update
    if @user.update(**user_params)
      render json: { user: UserSerializer.render_as_hash(authorize(@user)) }, status: :ok
    else
      render json: @user.errors.messages, status: :unprocessable_entity
    end
  end

  def reset_password
    user = User.where(status: :active).find_by(email: params.require(:email).strip.downcase)
    if user.present?
      user.reset_password!
      head :ok
    else
      render json: { message: "Email does not exist" }, status: :unprocessable_entity
    end
  end

  def reset_password_confirmation
    @token = params.require(:token)
    @user = User.find_by(reset_password_token: @token)
    raise Pundit::NotAuthorizedError, "token invalid" if @user.nil?
    @password = params.require(:password)

    @user.update(password: @password, reset_password_token: nil)
  end

  # def create
  #   user = User.create(**user_params)

  #   if user
  #     render json: { user: authorize(user) }, status: :ok
  #   else
  #     render json: user.errors.messages, status: :unprocessable_entity
  #   end
  # end

  # def destroy
  #   if @user.delete
  #     render json: { user: authorize(@user) }, status: :ok
  #   else
  #     render json: @user.errors.messages, status: :unprocessable_entity
  #   end
  # end

  # def activated_users
  #   @users = @users.search_name(params[:search]) if params[:search].present?
  #   pagy_blue(UserSerializer, policy_scope(@users.where(on_off: 'On').order(created_at: :desc)), extra: { view: :all })
  # end

  # def reset_password
  #   @user = User.find_by("LOWER(email) = ?", params.require(:email).strip.downcase)
  #   authorize(@user).reset_password! if @user

  #   head :ok
  # end

  # private

  def user
    @user = User.find(params.require(:id))
  end

  def users
    @users ||= User.all
  end

  def user_params
    params.permit(
      :firstname,
      :lastname,
      :email,
      :birth_date,
      :phone_number,
      :gender,
      :language,
      :access_level,
      :note_index_type,
      :photo
    )
  end
end

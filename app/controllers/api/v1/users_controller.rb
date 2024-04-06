class Api::V1::UsersController < ApplicationController
  # include Pagy::Backend
  # before_action :authenticate_user!, except: [:reset_password]

  # before_action :user, only: [:show, :update, :destroy]
  # before_action :users, only: [:index, :activated_users]

  # def index
  #   @users = @users.where(on_off: 'On')
  #   @users = @users.search_name(params[:search]) if params[:search].present?
  #   pagy_blue(UserSerializer, policy_scope(@users.order(created_at: :desc)), extra: { view: :all })
  # end

  # def show
  #   render json: {
  #     user: UserSerializer.render_as_json(authorize(@user), view: :all, search: params[:search].present? ? params[:search] : '', current_user: current_user)
  #   }, status: :ok
  # end

  # def update
  #   if @user.update(**user_params)
  #     render json: { user: UserSerializer.render_as_hash(authorize(@user)) }, status: :ok
  #   else
  #     render json: @user.errors.messages, status: :unprocessable_entity
  #   end
  # end

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

  # def user
  #   @user = User.find(params.require(:id))
  # end

  # def users
  #   @users ||= User.all
  # end

  # def user_params
  #   params.permit(
  #     :firstname,
  #     :lastname,
  #     :email,
  #     :birth_date,
  #     :hire_date,
  #     :address,
  #     :phone_number,
  #     :gender,
  #     :photo,
  #     :password,
  #     :language,
  #     :access_level,
  #     events: []
  #   )
  # end
end

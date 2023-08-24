class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create, :index]
  before_action :set_user, only: [:edit, :destroy]

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      token = jwt_encode(user_id: @user.id)
      if @user.user_type == 'doctor'
        render json: { token: token }, status: :ok, notice: "Successfully created of Doctor"
      else @user.user_type == 'patient'
        render json: { token: token }, status: :ok, notice: "Successfully created of Patient"
      end
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def edit
    user = User.edit(user_params)
    if user.save!
      render json: user, status: :created, notice: "Successfully updated"
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy!
      render notice: "Successfully deleted", status: :ok
    else
      render json: user.errors, status: :unprocessable_entity, notice: "Failed to delete"
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :user_type,)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

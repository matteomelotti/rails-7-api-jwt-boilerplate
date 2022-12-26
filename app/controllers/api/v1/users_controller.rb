class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :set_user, only: [:show, :destroy, :update]

  # GET /users
  def index
    @users = User.all
    render json: @users, status: 200
  end

  #GET /users/{id}
  def show
    render json: @user, status: 200
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: 200
    else
      render json: { errors: @user.errors.full_messages }, status: 401
    end
  end

  #PUT /users/{id}
  def update
    if @user.update(user_params)
      render json: @user, status: 200
    else
      render json: { errors: @user.errors.full_messages }, status: 401
    end
  end

  # DELETE /users/{id}
  def destroy
    if @user.destroy
      render json: { message: 'Destroyed!' }, status: 200
    else
      render json: { errors: @user.errors.full_messages }, status: 401
    end
  end

  private

  def user_params
    params.permit(:name, :username, :email, :password)
  end

  def set_user
    byebug
    @user = User.find(params[:id])
  end
end

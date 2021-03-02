class Admin::UsersController < ApplicationController
  def index
    if current_user.admin?
      @admin_users = User.all.includes(:tasks)
    else
      redirect_to tasks_path, notice: '管理者のみ閲覧できるページです。'
    end
  end

  def new
    @admin_user = User.new
  end

  def create
    @admin_user = User.new(user_params)
    if @admin_user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

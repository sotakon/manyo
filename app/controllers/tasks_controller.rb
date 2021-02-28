class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort_expired]
      @tasks = Task.order(limit: :desc)
    elsif params[:name].present?
      @tasks = Task.where(name: params[:name])
    elsif params[:stutas].present?
      @tasks = Task.where(stutas: params[:stutas])
    else
      @tasks = Task.all
    end
  end

# 追記する。render :new が省略されている。
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
    # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to tasks_path, notice: "タスクを作成しました！"
    else
    # 入力フォームを再描画します。
      render :new
    end
  end

  def show
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
  def task_params
    params.require(:task).permit(:name, :details, :id, :limit, :stutas, :priority, :sort_expired)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end

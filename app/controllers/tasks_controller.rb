class TasksController < ApplicationController
before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @task = Task.all.page(params[:page]).per(15)
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end
  
  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'タスクは正常に更新されました。'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした。'
      render :edit
    end
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = 'タスクが追加されました。'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが追加されませんでした。'
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'タスクは正常に削除されました。'
    redirect_to tasks_url
  end

  private
  
  # Strong Parameter
  def set_task
    @task = Task.find(params[:id])
  end
    
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
end

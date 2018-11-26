class TasksController < ApplicationController
before_action :require_user_logged_in
before_action :correct_user, only: [:index, :new, :show, :edit, :update, :destroy]

 def index
   @tasks = Task.order(created_at: :desc).page(params[:page]).per(3)
 end

 def show
 end

 def new
   @task = Task.new
 end

def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクが投稿されました'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'タスクが投稿されません'
      render 'toppages/index'
    end
end
  
  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
       flash[:success] = 'タスクが編集されました'
       redirect_to @task
       else
       flash.now[:danger] = 'タスクが編集されませんでした'
       render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'タスクを削除しました。'
    redirect_back(fallback_location: root_path)
  end
 
private
 
  def set_task
     @task = Task.find(params[:id])
  end
  
  def task_params
     params.require(:task).permit(:content,:status)
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
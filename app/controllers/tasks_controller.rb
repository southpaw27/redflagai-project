class TasksController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def create
    outcome = Interactions::Tasks::Create.run(
      project_manager: task_params[:project_manager_id],
      project: task_params[:project_id],
      title: task_params[:title],
      description: task_params[:description],
      work_focus: task_params[:work_focus],
      due_date: task_params[:due_date],
      status: task_params[:status],
      employee: task_params[:employee_id],
      parent_task: task_params[:parent_task_id],
    )
    if outcome.valid?
      redirect_to "/"
    else
      render "edit"
    end
  end

  def change_status
    render "change_status", locals: { task: @task }
  end

  def update_status
    outcome = Interactions::Tasks::ChangeStatus.run(
      task: @task,
      change_user: current_user,
      status: task_params[:status],
    )
    if outcome.valid?
      redirect_to "/"
    else
      render "change_status"
    end
  end

  def delete
  end

  def task_params
    params.require(:task).permit(:title, :description, :project_manager_id, :parent_task_id, :employee_id, :project_id, :status, :due_date, :work_focus)
  end
end

require "rails_helper"

describe Task do

  let(:project_manager) { create(:user, :project_manager) }
  let(:project) { create(:project, project_manager: project_manager, organization: project_manager.organization) }
  let(:parent_task) { Task.create(title: "Parent task", project_manager: project_manager, project: project) }
  let(:employee) { create(:user, :employee, email: "employee@test.com", organization: project_manager.organization) }

  it "can have subtasks" do
    parent_task = create(:task, title: "Parent task", project_manager: project_manager, project: project)

    parent_task.subtasks << [
      build(:task, title: "Child Task 1", project_manager: project_manager, project: project),
      build(:task, title: "Child Task 2", project_manager: project_manager, project: project)]
    parent_task.save
    parent_task.reload

    expect(parent_task.subtasks.count).to eq 2
  end

  it "can have a parent task" do
    parent_task = create(:task, title: "Parent task", project_manager: project_manager, project: project)

    child_task = parent_task.subtasks.create(
      title: "Child Task 1",
      project_manager: project_manager,
      project: project,
      status: Task::Statuses::NOT_STARTED)

    child_task.reload
    expect(child_task.parent_task).to eq parent_task
  end

  it "will not allow a project manager to be assigned as an employee" do
    expect(parent_task.update(employee: project_manager)).to be false
  end

  it "will not allow an employee to be assigned as a project manager" do
    expect(parent_task.update(project_manager: employee)).to be false
  end
end


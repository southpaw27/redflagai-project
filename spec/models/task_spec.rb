require "rails_helper"

describe Task do

  let(:project_manager) { create(:project_manager) }
  let(:project) { create(:project, project_manager: project_manager) }
  let(:parent_task) { Task.create(title: "Parent task", project_manager: project_manager, project: project) }

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
end


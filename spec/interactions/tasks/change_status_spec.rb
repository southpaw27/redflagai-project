require "rails_helper"

describe Interactions::Tasks::ChangeStatus do
  let(:project_manager) { create(:project_manager) }
  let(:project) { create(:project, project_manager: project_manager)}
  let(:task) { create(:task, project_manager: project_manager, project: project, employee: employee) }
  let(:other_project_manager) { create(:project_manager, name: "Other manager", email: "other@test.com") }
  let(:employee) { create(:employee) }
  let(:other_employee) { create(:employee, email: 'another@test.com') }

  it 'will error if neither a project manager nor an employee is present' do
    outcome = Interactions::Tasks::ChangeStatus.run(task: task, status: Task::Statuses::DONE)
    expect(outcome.errors.count).to eq 3 # all checks will error, the first will be this test
    expect(outcome.errors.first.message).to eq "must have one change user"
  end

  it 'will error if both a project manager and an employee is present' do
    outcome = Interactions::Tasks::ChangeStatus.run(task: task, status: Task::Statuses::DONE, project_manager: project_manager, employee: employee)
    expect(outcome.errors.count).to eq 1
    expect(outcome.errors.first.message).to eq "must have one change user"
  end

  it 'will error if project manager is not assigned' do
    outcome = Interactions::Tasks::ChangeStatus.run(task: task, project_manager: other_project_manager, status: Task::Statuses::DONE)
    expect(outcome.errors.count).to eq 1
    expect(outcome.errors.first.message).to eq "change user is not assigned to the task"
  end

  it 'will error if the project manager is trying to assign an incorrect status' do
    outcome = Interactions::Tasks::ChangeStatus.run(task: task, project_manager: project_manager, status: Task::Statuses::WORKING)

    expect(outcome.errors.count).to eq 1
    expect(outcome.errors.first.message).to eq "status change not allowed"
  end

  it 'will error if the employee is not assigned' do 
    outcome = Interactions::Tasks::ChangeStatus.run(task: task, employee: other_employee, status: Task::Statuses::WORKING)
    expect(outcome.errors.count).to eq 1
    expect(outcome.errors.first.message).to eq "change user is not assigned to the task"
  end

  it 'will error if the employee is trying to assign an incorrect status' do
    outcome = Interactions::Tasks::ChangeStatus.run(task: task, employee: employee, status: Task::Statuses::DONE)
    expect(outcome.errors.count).to eq 1
    expect(outcome.errors.first.message).to eq "status change not allowed"
  end

  it 'will update the task if an employee submits a correct status' do
    expect(task.status).to eq Task::Statuses::NOT_STARTED
    outcome = Interactions::Tasks::ChangeStatus.run(task: task, employee: employee, status: Task::Statuses::WORKING)
    expect(outcome.valid?).to eq true

    task = outcome.result
    # Check result
    expect(task.status).to eq Task::Statuses::WORKING

    # Verify persisted
    task.reload
    expect(task.status).to eq Task::Statuses::WORKING
  end

  it 'will update the task if a project manager submits a correct status' do
    expect(task.status).to eq Task::Statuses::NOT_STARTED
    outcome = Interactions::Tasks::ChangeStatus.run(task: task, project_manager: project_manager, status: Task::Statuses::DONE)
    expect(outcome.valid?).to eq true

    task = outcome.result
    # Check result
    expect(task.status).to eq Task::Statuses::DONE

    # Verify persisted
    task.reload
    expect(task.status).to eq Task::Statuses::DONE
  end
end
require "rails_helper"

describe Interactions::Tasks::Create do
  let(:project_manager) { create(:user, :project_manager) }
  let(:project) { create(:project, project_manager: project_manager, organization: project_manager.organization)}

  it 'will create a new task' do
    outcome = Interactions::Tasks::Create.run(
      project: project,
      project_manager: project_manager,
      title: "Test Title",
      description: "Test description."
    )

    expect(outcome.valid?).to be true
    task = outcome.result
    expect(task.title).to eq "Test Title"
    expect(task.project_manager).to eq project_manager
  end
end
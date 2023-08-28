class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.string :work_focus
      t.datetime :due_date
      t.string :status
      t.integer :project_manager_id
      t.integer :parent_task_id
      t.integer :project_id
      t.integer :employee_id

      t.timestamps
    end
  end
end

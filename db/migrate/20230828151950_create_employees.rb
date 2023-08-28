class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :title
      t.string :work_focus

      t.timestamps
    end
  end
end

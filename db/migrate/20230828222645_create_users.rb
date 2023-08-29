class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :role_id
      t.string :role_type

      t.timestamps
    end
  end
end

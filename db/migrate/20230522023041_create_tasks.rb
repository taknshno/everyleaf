class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.string :status
      t.string :priority
      t.date :end_date

      t.timestamps
    end
  end
end

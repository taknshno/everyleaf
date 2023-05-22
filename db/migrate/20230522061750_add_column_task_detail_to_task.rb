class AddColumnTaskDetailToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :task_detail, :text, null: false
  end
end

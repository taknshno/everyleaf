class ChangeDataStatusAndPriorityToTask < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :status, :integer, using: 'status::integer'
    change_column :tasks, :priority, :integer, using: 'priority::integer'
  end
end

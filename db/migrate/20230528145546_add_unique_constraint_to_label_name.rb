class AddUniqueConstraintToLabelName < ActiveRecord::Migration[6.1]
  def change
    add_index :labels, :label_name, unique: true
  end
end

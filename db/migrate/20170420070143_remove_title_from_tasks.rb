class RemoveTitleFromTasks < ActiveRecord::Migration[5.0]
  def change
    remove_column :tasks, :title, :string
  end
end

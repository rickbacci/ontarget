class AddCurrentProjectToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_project, :string
  end
end

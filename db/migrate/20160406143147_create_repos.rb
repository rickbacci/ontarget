class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.references :user, index: true, foreign_key: true
      t.string :owner_login
      t.integer :owner_id
      t.integer :user_id
      t.string :name
      t.string :description
      t.string :has_issues, :boolean, default: false
      t.string :active, :boolean, default: true
      t.time :updated_at

      t.timestamps null: false
    end
  end
end

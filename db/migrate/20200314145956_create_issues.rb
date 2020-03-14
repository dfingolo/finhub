class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.integer :number
      t.string :title
      t.string :state
      t.boolean :locked
      t.integer :github_id
      t.integer :github_user_id
      t.string :github_url
      t.datetime :github_created_at
      t.datetime :github_updated_at
      t.datetime :github_closed_at

      t.timestamps
    end
  end
end

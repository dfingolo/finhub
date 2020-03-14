class CreateIssueEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :issue_events do |t|
      t.string :action
      t.jsonb :issue_changes
      t.string :sender
      t.references :issue, foreign_key: true

      t.timestamps
    end
  end
end

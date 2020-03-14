class AddRepositoryToIssue < ActiveRecord::Migration[5.2]
  def change
    add_reference :issues, :repository, foreign_key: true
  end
end

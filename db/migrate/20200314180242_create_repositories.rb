class CreateRepositories < ActiveRecord::Migration[5.2]
  def change
    create_table :repositories do |t|
      t.string :username
      t.string :name
      t.uuid :token, null: false, default: "uuid_generate_v4()", index: true, unique: true

      t.timestamps
    end
  end
end

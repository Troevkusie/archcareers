class CreateCandidates < ActiveRecord::Migration[8.1]
  def change
    create_table :candidates do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
    add_index :candidates, :email, unique: true
  end
end

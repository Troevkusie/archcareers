class CreateEmployers < ActiveRecord::Migration[8.1]
  def change
    create_table :employers do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
    add_index :employers, :email, unique: true
  end
end

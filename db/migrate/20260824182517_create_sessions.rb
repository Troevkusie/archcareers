class CreateSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :sessions do |t|
      t.references :candidate, null: true, foreign_key: true
      t.references :employer, null: true, foreign_key: true
      t.string :token
      t.string :user_agent
      t.string :ip_address

      t.timestamps
    end
    add_index :sessions, :token, unique: true
  end
end




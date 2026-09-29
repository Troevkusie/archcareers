class AddIndexOnEmployersEmail < ActiveRecord::Migration[8.1]
  def change
    add_index :employers, :email, unique: true
  end
end

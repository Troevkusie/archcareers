class AddNotNullToAuthColumns < ActiveRecord::Migration[8.1]
  def change
    change_column_null :candidates, :email, false
    change_column_null :candidates, :password_digest, false
    change_column_null :employers, :email, false
    change_column_null :employers, :password_digest, false
    change_column_null :sessions, :token, false
  end
end

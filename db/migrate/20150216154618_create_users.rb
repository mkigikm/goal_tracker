class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name,            null: false
      t.string :password_digest, null: false
      t.string :session_token,   null: false
    end
    add_index :users, :name, unique: true
  end
end

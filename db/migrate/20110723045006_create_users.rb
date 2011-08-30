class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string   :username
      t.boolean  :admin
      t.string   :encrypted_password,     :limit => 128, :default => "", :null => false
      t.string   :salt
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer  :sign_in_count,                         :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps
    end
    add_index :users, :username, :unique => true
    add_index :users, :reset_password_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end
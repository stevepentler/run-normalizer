class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :user_id
      t.string :email
      t.string :provider
      t.string :token
      
      t.string :username
      t.string :display_name
      t.string :state
      t.float :height
      t.float :weight
      t.string :gender
      t.string :birthday

      t.timestamps null: false
    end
  end
end

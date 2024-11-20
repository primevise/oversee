class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :email_address, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.string :full_name
      t.string :access_token
      t.date :birthday

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, null: false
      t.string :confirmation_token, null: true
      t.timestamps
    end

    add_index :users, :email,unique: true
    add_index :users, :confirmation_token
  end
end

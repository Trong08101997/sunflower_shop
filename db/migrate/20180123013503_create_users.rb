class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :sex
      t.string :address
      t.string :phone_number
      t.string :password_digest
      t.integer :role, null: false, default: 0

      t.timestamps
    end
  end
end

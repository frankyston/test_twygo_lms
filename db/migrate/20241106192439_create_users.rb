class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :email,           null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.string :name
      t.boolean :verified, null: false, default: false

      t.integer :role, null: false, default: 0

      t.timestamps
    end
  end
end

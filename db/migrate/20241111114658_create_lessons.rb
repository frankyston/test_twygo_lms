class CreateLessons < ActiveRecord::Migration[7.2]
  def change
    create_table :lessons do |t|
      t.string :title, null: false, index: true
      t.text :description, null: false
      t.integer :time, null: false
      t.integer :file_size, null: false
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end

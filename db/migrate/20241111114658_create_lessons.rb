class CreateLessons < ActiveRecord::Migration[7.2]
  def change
    create_table :lessons do |t|
      t.string :title, null: false, index: true
      t.text :description, null: false
      t.text :short_description, null: false
      t.integer :duration, default: 0
      t.integer :file_size, default: 0
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateCourses < ActiveRecord::Migration[7.2]
  def change
    create_table :courses do |t|
      t.string :title, null: false, index: true
      t.text :description, null: false
      t.text :short_description, null: false
      t.string :instructor, null: false
      t.date :started_at, null: false, index: true
      t.date :ended_at, null: false, index: true
      t.boolean :emphasis, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :language
      t.string :course_name
      t.integer :length
      t.string :level
      t.string :provider
      t.integer :length
      t.integer :likes
      t.integer :rating
      t.integer :views
      t.string :intro

      t.timestamps null: false
    end
  end
end

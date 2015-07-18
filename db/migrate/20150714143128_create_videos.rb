class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :length
      t.string :title
      t.string :intro
      t.integer :course_id
      t.string :url
      
      t.timestamps null: false
    end
  end
end

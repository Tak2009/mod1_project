class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
       t.integer :student_id
       t.integer :student_own_level
       t.integer :tutor_id
       t.integer :rating_for_tutor
       t.string :comment
       t.timestamps null: false
    end   
  end
end

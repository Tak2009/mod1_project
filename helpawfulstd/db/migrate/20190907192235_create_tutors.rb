class CreateTutors < ActiveRecord::Migration[6.0]
  def change
    create_table :tutors do |t|
      t.string :t_profile_name
      t.string :location
      t.string :language
      t.integer :experience
      t.integer :price
      t.string :contact_email
      t.timestamps null: false
    end
  end
end

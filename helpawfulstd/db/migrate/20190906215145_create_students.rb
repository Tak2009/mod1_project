class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :s_profile_name
      t.string :location
      t.integer :age
      t.string :contact_email
      t.string :password
      t.timestamps null: false
    end
  end
end

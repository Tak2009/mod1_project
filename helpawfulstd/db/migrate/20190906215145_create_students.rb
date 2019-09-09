class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :location
      t.integer :age
      t.string :contact_email
      t.timestamps null: false
    end
  end
end

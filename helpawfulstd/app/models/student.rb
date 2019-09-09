class Student < ActiveRecord::Base
   has_many :reviews
   has_many :tutors, through: :reviews

end

    

class Student < ActiveRecord::Base
   has_many :reviews
   has_many :tutors, through: :reviews

   
   def self.s_create_profile(profile_name, location, age, contact_email) # creating a profilr. No duplicate profile name allowed
       student = Student.find_or_create_by(profile_name: profile_name)
       student.update(location: location)
       student.update(age: age)
       student.update(contact_email: contact_email)
   end

end

    

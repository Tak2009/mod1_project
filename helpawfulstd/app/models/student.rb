class Student < ActiveRecord::Base
   has_many :reviews
   has_many :tutors, through: :reviews

   
   def self.s_create_profile(profile_name, location, age, contact_email) # creating a profile. No duplicate profile name allowed
       student = Student.find_or_create_by(profile_name: profile_name)
       student.update(location: location)
       student.update(age: age)
       student.update(contact_email: contact_email)
   end

   # def make_a_review(student_own_level, tutor_id, rating_for_tutor, comment)
    # tutor_profile_name = Tutor.all.find_by
       #Review.create(student_id: self.id, student_own_level: student_own_level, tutor_id: tutor_id, rating_for_tutor: rating_for_tutor, comment: comment)

   # end

end

    

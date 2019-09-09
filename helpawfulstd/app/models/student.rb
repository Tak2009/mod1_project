class Student < ActiveRecord::Base
   has_many :reviews
   has_many :tutors, through: :reviews

   
   def self.s_create_profile(s_profile_name, location, age, contact_email) # creating a profile. No duplicate profile name allowed
       student = Student.find_or_create_by(s_profile_name: s_profile_name)
       student.update(location: location)
       student.update(age: age)
       student.update(contact_email: contact_email)
   end

    def make_a_review(student_own_level, t_profile_name, language, rating_for_tutor, comment)
        tutor  = Tutor.all.find_by(t_profile_name: t_profile_name, language: language)  # Need find tutor_id by name and language combination as tutor-language = 1 instance
        Review.create(student_id: self.id, student_own_level: student_own_level, tutor_id: tutor.id, rating_for_tutor: rating_for_tutor, comment: comment)
    end

end

    

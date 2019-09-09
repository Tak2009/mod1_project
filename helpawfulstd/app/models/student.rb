class Student < ActiveRecord::Base
   has_many :reviews
   has_many :tutors, through: :reviews

   
   # C
    def self.s_create_profile(s_profile_name, location, age, contact_email) # creating a profile. No duplicate profile name allowed
        student = Student.find_or_create_by(s_profile_name: s_profile_name)
        student.update(location: location)
        student.update(age: age)
        student.update(contact_email: contact_email)
    end

    def want_to_make_a_review(student_own_level, t_profile_name, language, rating_for_tutor, comment)
        tutor  = Tutor.all.find_by(t_profile_name: t_profile_name, language: language)  # Need to "find" tutor_id by name (as student user does input with tutor user profile name) and language combination as david-php = 1 instance and david-Ruby = 1 instance
        Review.create(student_id: self.id, student_own_level: student_own_level, tutor_id: tutor.id, language: tutor.language, rating_for_tutor: rating_for_tutor, comment: comment) # user input "language" is just ued for findng a tutor instance with the language. 
        # therefore, for lasnguage attribute for review in here is retrived from tutor attribute  => tutor.language
    end

    # R
    def want_to_check_my_reviews # all the reviews
        Review.all.where(student_id: self.id)
    end

    def want_to_check_all_reviews_by_language # to find a good tutor that student wants to have support in the language
        Review.all.where(student_id: self.id)
    end

end

    

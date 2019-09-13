require_relative '../../config/environment'
require 'tty-prompt'

# Memo 1. Do NOT use any  variable names which are used as attributes otherwise you will screw up!!!!! >>>> Undefined Class Method will be triggered!!!
# Memo 2. Remeber the reason why I set class CLI in this file!!!!!!!


require 'pry'

class CLI

    def initialize
        @student_u = nil
        @tutor_u = nil
    end

    def run
        puts "Hello. Please log in or sign up"
        prompt = TTY::Prompt.new
        choice = prompt.select("Please, select ", ["Sign up as Student", "Sign up as Tutor", "Login", "Exit"])
        if choice == "Sign up as Student" 
             student_signup
        elsif choice == "Sign up as Tutor"
             tutor_signup
        elsif choice == "Login"
             login 
        else 
             puts "We hope we will see you soon again!" 
             
        end 
    end 
# ======================= From here, For Student User Type=====================================================================================

    # Student C
# No validation applied on email so that no duplicate email registered in the database. Need to woerk on iuf time allows
    def student_signup
        puts "Please provide the following information to create your profile"
        prompt = TTY::Prompt.new
        name = prompt.ask("What is your name?")
        place = prompt.ask("Your city?")
        how_old = prompt.ask("Your age?")
        which_language = prompt.ask("Which language you wanna learn?")
        email = prompt.ask("Your email? This will be used as your login ID once your profile created")
        pw = prompt.ask("Your password?")
        @student_u = Student.create(s_profile_name: name, location: place, age: how_old, wanna_learn: which_language, contact_email: email, password: pw)
        puts "Thank you! All done!"
        student_profile_screen
    end

    # Both Student and Tutor Users
    def login
        prompt = TTY::Prompt.new
        type = prompt.select("Please, select ", ["Login as Tutor?", "Login as Student?"])
        if type == "Login as Tutor?"
            login_tutor
        else 
            login_student
        end
    end

    # For both Student and Tutor users
    def logout 
        go_to_exit
    end
    
    # Student Login
# I should work on password reset if time allows
    def login_student
        prompt = TTY::Prompt.new
        email = prompt.ask("What is your email address??")
        pw = prompt.ask("What is your password??") 
        @student_u = Student.all.find_by(contact_email: email)

        if @student_u == nil # Student thinks he/she has the account but actually not case
            puts "We can not find your email. Please sign up" 
            student_signup
        elsif email == @student_u.contact_email && pw == @student_u.password # Login process. both ID and password must match agfainst database
            student_profile_screen
        else
            puts "Either your email or password is incorrect. Please try again" # email exits but app does not want to explicitly notify that the user has an account at this stage
            login_student

        end
        
    end

    # Student Main screen
    def student_profile_screen
        prompt = TTY::Prompt.new
        puts "Welcome back, #{@student_u.s_profile_name}!"
        menu = prompt.select("Please, select one of your options!", ["Update Profile", "View Your Profile", "Show Reviews", "Write Review", "Search Tutor", "Delete Profile", "Log out"])
        
        if menu == "Update Profile"
            s_update_profile
        elsif menu == "View Your Profile"
            s_view_profile
        elsif menu == "Show Reviews"
            s_show_reviews
        elsif menu == "Write Review"
            s_write_review
        elsif menu == "Search Tutor"                  
            s_search_tutor
        elsif menu == "Delete Profile"
            s_delete_profile
        else menu == "Log out"
            logout   
        end
    end
    
    # Student U
     def s_update_profile
        prompt = TTY::Prompt.new
        selection_excluding_system_generated = Student.column_names.select{|attr| attr != "id" && attr != "created_at" && attr != "updated_at"} 
        attr_to_change = prompt.select("What information would you like to update?", selection_excluding_system_generated)
        new_info = prompt.ask("Please enter the new #{attr_to_change}")
        @student_u.update({attr_to_change => new_info})
        puts "Updated!"
        student_profile_screen
     end

     # Student R
     def s_view_profile
        puts "Your profile!"
        # p @student_u
        # p [@student_u].map{|t| {:name=> @student_u.s_profile_name, :your_area=> @student_u.location, :your_age=> @student_u.age, :your_target_language=> @student_u.wanna_learn, :email=> @student_u.contact_email, :pw=> @student_u.password}}
        column_without = Student.all.column_names.select {|c| c != "id" && c != "created_at" && c != "updated_at"}
        puts column_without.map {|t| @student_u[t]}
        
        sleep(5)
        puts "redirecting...."
        student_profile_screen
    end

    # Student R
    def s_show_reviews
        puts "All of your reviews are...."
        p @student_u.reviews
        sleep(5)
        puts "redirecting...."
        student_profile_screen
    end

    # Student W
    def s_write_review
        puts "Please answer follwing questions. You can write reviews for tutors in our platform. Make sure you treat people fairly and as nice as pissbile :)"
        prompt = TTY::Prompt.new
        level = prompt.ask("What is your knowledge level with 5 being highest?")
    # Need to be cahnged to a list with email
        email = prompt.ask("What is your tutor email? We need this for validation!") # filterling by name is too weak as there must be a lot of daves, toms for example. email is considered as unique enough
        tutor_rating = prompt.ask("Give a rating please with 5 being highest")
        something_to_say = prompt.ask("Any comment?")

        t_id_by_email = Tutor.all.find_by(contact_email: email) # get the referece for the tutor

        Review.create(student_id: @student_u.id, student_own_level: level, tutor_id: t_id_by_email.id, language: t_id_by_email.language, rating_for_tutor: tutor_rating, comment: something_to_say)
        puts "Thank youfor your review. We always appreciate your feedback!!"
        
        student_profile_screen
    end

    # Student R very simple looking into Tutor table. This search is NOT Review dependant
# data input validation NOT implemented at all. Need  to work on if time allows
    def s_search_tutor

        prompt = TTY::Prompt.new
        menu = prompt.select("Which serach would you fancy?", ["Simple(search by location and language you wanna learn)", "Advanced(based on rerviews)"])
        if menu == "Advanced(based on rerviews)"
            s_advanced_search_tutor
        else
            place = prompt.ask("Enter your location or anywhere you wanna check!")   
            which_language = prompt.ask("Which language you wanna learn?")
         
            search_result_t = Tutor.all.where(location: place).where(language: which_language)
                if search_result_t.length == 0
                    puts "No match... Try again :("
                    
                else
                    puts "here you go!"
                    puts search_result_t.map{|t| {:name => t.t_profile_name, :locartion => t.location, :language => t.language, :experience => t.experience, :hourly_rate => t.price, :email => t.contact_email}}
                    # search_result_t.each do |element_hash| p element_hash end  ==> this returns unnecessary information
                end  
        end

        # if prompt.yes?("Wanna serch again? Otherwise going back to your profile screen!")
        #     s_search_tutor
        # else
        #    puts "redirecting...."
        # end
           student_profile_screen
    end


    # Student R using map and filter for advanced search based on Reviews
# data input validation NOT implemented at all. Need  to work on if time allows
    def s_advanced_search_tutor

        puts "Let me help you search a good tutor near you!"
        prompt = TTY::Prompt.new
        what_language = prompt.ask("In what language are you looking?") # 1 from Review table
        tutor_rating = prompt.ask("Minimum tutor rating?") # 2 from Review table
        puts "we need more information!"
        place = prompt.ask("In which area, are you looking?") # 3 from Tutor table
        experieced_or_not = prompt.ask("Select minimum experience level with 5 being highest plase.") # 4 from Tutor table
        
        puts "Ok, thank you! hold on a sec pllease, We are serching for you!"
        
        reviews_array = Review.all.where(language: what_language).where("rating_for_tutor >= #{tutor_rating}") # narrow down with #1 and #2
        # tutor_id_only_array = reviews_array.map{|tutor_with_conditions| tutor_with_conditions.tutor_id}.uniq # reviews contains multiple reviews for 1 specific tutor user
          
        
       
        a = reviews_array.map{|t| t.tutor}.uniq
     
        # tutor_list_with_conditions = Tutor.all.where(id: tutor_id_only_array).where(location: place).where("experience >= #{experieced_or_not}") # need to sort with #3 and #4 by using Tutor table
        b = a.select {|t| t.location == place && t.experience >= experieced_or_not.to_i} 

        if b.length == 0
            puts "No match :("
        else
            puts "Here is the result!"
            puts b.map {|t| {:name => t.t_profile_name, :location => t.location, :language => t.language, :experience => t.experience, :hourly_rate => t.price, :email => t.contact_email}}
            # tutor_list_with_conditions.each do |element_hash| p element_hash end
        end

        # if prompt.yes?("Wanna serch again? Otherwise going back to your profile screen!")
        #    s_search_tutor
        # else
        # puts "redirecting...."
        # end
        student_profile_screen
    end

    


    

    # Student D
    def s_delete_profile
        prompt = TTY::Prompt.new
        
        if prompt.no?("Are you sure you would like to delete to your profile?, This will also delete all of your reviews you made in the past")
            puts "glad to hear!"
            student_profile_screen
        else
           @student_u.reviews.destroy_all # destory reviews(instances in Reviews written by the user) first otherwise we can not find the reviews by the user id. hard delete
           @student_u.destroy
           puts "Thank you for being a great student here! Hope to see you soon again!!"
        end
      end
      
      # For both Student and Tutor Users
      def go_to_exit
          puts "Byebye!"
          exit
      end
    
# ======================= From here, For Tutor User Type=====================================================================================
     
     # Totor C 
# No validation applied on email so that no duplicate email registered in the database. Need to woerk on iuf time allows
     def tutor_signup
        puts "Please provide the following information to create your profile, tutor"
        prompt = TTY::Prompt.new
        name = prompt.ask("Your profile name, tutor?")
        place = prompt.ask("Your city, tutor?")
        language_your_speciality = prompt.ask("Which language you can teach, tutor?")
        how_good = prompt.ask("Your experience level with 5 being highest, tutor?")
        hourly_rate = prompt.ask("How expensive are you (hourly rate), tutor?")
        email = prompt.ask("Your email, tutor? This will be used as your login ID once your profile created")
        pw = prompt.ask("Your password, tutor?")
        @tutor_u = Tutor.create(t_profile_name: name, location: place, language: language_your_speciality, experience: how_good, price: hourly_rate, contact_email: email, password: pw)
        puts "Thank you, tutor! All done!"
        tutor_profile_screen
     end
     
     # Tutor Login
     def login_tutor
        prompt = TTY::Prompt.new
        email = prompt.ask("What is your email address, tutor??")
        pw = prompt.ask("What is your password, tutor??") 
        @tutor_u = Tutor.all.find_by(contact_email: email)

        if @tutor_u == nil # Tutor thinks he/she has the account but actually not case
            puts "We can not find your email, tutor. Please sign up" 
            tutor_signup
        elsif email == @tutor_u.contact_email && pw == @tutor_u.password # Login process. both ID and password must match agfainst database
            tutor_profile_screen
        else
            puts "Either your email or password is incorrect. Please try again, tutor" # email exits but app does not want to explicitly notify that the user has an account at this stage
            login_tutor
        end
        
    end

     # Tutor Main screen
    def tutor_profile_screen
        prompt = TTY::Prompt.new
        puts "Welcome back, #{@tutor_u.t_profile_name}, tutor!"
        menu = prompt.select("Select one of your options, tutor!", ["Update Profile", "Search Student", "Delete Profile", "Log out"])
        
        if menu == "Update Profile"
            t_update_profile
        elsif menu == "Search Student"                  
            t_search_student
        elsif menu == "Delete Profile"
            t_delete_profile
        else
            logout
        end
    end


    # Tutor R very simple looking into Student table. This search is NOT Review dependant
# data input validation NOT implemented at all. Need  to work on if time allows
    def t_search_student

        prompt = TTY::Prompt.new
        menu = prompt.select("Which serach would you fancy, tutor?", ["Simple(search by location)", "Advanced(based on rerviews)"])  # no need to input langiage in Tutor user as it has langage attr assigned 
        if menu == "Advanced(based on rerviews)"
            t_advanced_search_student
        else
            place = prompt.ask("Enter your location or anywhere you wanna check, tutor!")
            language_to_teach = prompt.ask("Which language?")
    # binding.pry
            search_result = Student.all.where(location: place).where(wanna_learn: language_to_teach)
    # binding.pry
               if search_result.length == 0
                  puts "No match, tutor... :("
                  t_search_student
               else
                  puts "here you go!"
                  puts search_result.map {|t| {:name => t.s_profile_name, :location => t.location, :age => t.age, :language => t.wanna_learn, :email => t.contact_email}}
                  # serach_result.each do |element_hash| p element_hash end  # need t think of better user profile structure for tutor
               end
        end

        # if prompt.yes?("Wanna serch again? Otherwise going back to your profile screen!")
        #      t_search_student
        # else
        #     puts "redirecting...."
            tutor_profile_screen
        # end
            
    end

    def t_advanced_search_student

        puts "Let me help you search a good tutor near you!"
        prompt = TTY::Prompt.new
        tutor_rating = prompt.ask("Tutor, please select minimum tutor rating from student? Am sure you wanna find an easygoing student!") # 1 from Review table
        difficult_to_teach = prompt.ask("Lower is more beginner. With 5(advanced student) being highest. If you wanna avoid beginners, enter a higher number") # 2 from Review table
        puts "We need more information, tutor!"
        place = prompt.ask("In which area, are you looking, tutor?") # 3 from Student table
        
        puts "Ok, tutor! Hold on a sec pllease, We are serching for you!"
        
        reviews_array = Review.all.where(language: @tutor_u.language).where("student_own_level >= #{difficult_to_teach}").where("rating_for_tutor >= #{tutor_rating}") # narrow down with #1 and #2 and language(self). totor's own language auto-set with self attribute for filtering
        student_id_only_array = reviews_array.map{|student_with_conditions| student_with_conditions.student_id}.uniq # students can have many reviews for 1 specific tutor user
    # binding.pry    
        student_list_with_conditions = Student.all.where(id: student_id_only_array).where(location: place) # need to sort with #3 in Student table
     
        if student_list_with_conditions.length == 0
            puts "No match :("

        else
            puts "Here is the result!"
            puts student_list_with_conditions.map {|t| {:name => t.s_profile_name, :location => t.location, :age => t.age, :language => t.wanna_learn, :email => t.contact_email}}
            # student_list_with_conditions.each do |element_hash| p element_hash end
        end

        # if prompt.yes?("Wanna serch again? Otherwise going back to your profile screen!")
        #    t_search_student
        # else
        #      puts "redirecting...."
        tutor_profile_screen
        # end
            
    end

    
    # Tutor U
    def t_update_profile
        prompt = TTY::Prompt.new
        selection_excluding_system_generated = Tutor.column_names.select{|attr| attr != "id" && attr != "created_at" && attr != "updated_at"} 
        attr_to_change = prompt.select("What information would you lkike to update, tutor?", selection_excluding_system_generated)
        new_info = prompt.ask("Please enter the new #{attr_to_change}")
        @tutor_u.update({attr_to_change => new_info})
        puts "Updated!"
        tutor_profile_screen
    end


    # Tutor D
    def t_delete_profile
        prompt = TTY::Prompt.new
        if prompt.no?("Are you sure you would like to delete to your profile?") # in my app, only Student Users can write reviews so I will not delete the reviews related to tutor user
            puts "glad to hear that you wanna stay here!"
            tutor_profile_screen
        else
        @tutor_u.destroy
        puts "Thank you for being a great student here! Hope to see you soon again!!"
        end
    end

        
        
end







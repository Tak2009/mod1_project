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
             tutor_user
        elsif choice == "Login"
             login 
        else 
             puts "We hope we will see you soon again!" 
             sleep(5)  # exit after 5 seconds
        end 
    end 
        # Student C
    def student_signup
        puts "Please provide the following information to create your profile"
        prompt = TTY::Prompt.new
        name = prompt.ask("What is your name?")
        place = prompt.ask("Your city?")
        how_old = prompt.ask("Your age?")
        email = prompt.ask("Your email? This will be used as your login ID once your profile created")
        pw = prompt.ask("Your password?")
        @student_u = Student.create(s_profile_name: name, location: place, age: how_old, contact_email: email, password: pw)
        puts "Thank you! All done!"
        student_profile_screen
    end

    # Both Student and Tutor Users
    def login
        prompt = TTY::Prompt.new
        type = prompt.select("Please, select ", ["Login as Tutor?", "Login as Student?"])
        if type == "Log in as Tutor?"
            login_tutor
        else 
            login_student
        end
    end

     
    # For both Student and Tutor users
    def logout 
        puts "Goodby! See you soon!"
        
    end
    
    # Student
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
# I should work on password reset if time allows
        end
        
    end


    # Student Main screen
    def student_profile_screen
        prompt = TTY::Prompt.new
        puts "Welcome back, #{@student_u.s_profile_name}!"
        menu = prompt.select("Please, select one of your options!", ["Update Profile", "Write Review", "Search Tutor", "Delete Profile","Log out"])
        
        if menu == "Update Profile"
            s_update_profile
        elsif menu == "Write Review"
            s_write_review
        elsif menu == "Search Tutor"                  
            s_search_tutor
        elsif menu == "Delete Profile"
            s_delete_profile
        else
            logout
        end

    end
    
    # Student R  use map and filter for advanced search based on Reviews
    def s_search_tutor
        puts "Let me help you search a good tutor near you!"
        prompt = TTY::Prompt.new
        
        what_language = prompt.ask("In what language are you looking?") # 1 from Review table
        tutor_rating = prompt.ask("Minimum tutor rating?") # 2 from Review table
        puts "we need more information!"
        place = prompt.ask("In which area, are you looking?") # 3 from Tutor table
        experieced_or_not = prompt.ask("Select minimum experience level with 5 being highest plase.") # 4 from Tutor table
        "Ok, thank you! hold on a sec pllease, We are serching for you!"
        # narrow down with #1 and #2
        reviews_array = Review.all.where(language: what_language).where("rating_for_tutor > #{tutor_rating}")
        tutor_id_only_array = reviews_array.map{|tutor_with_conditions| tutor_with_conditions.tutor_id}
        # need to sort with #3 and #4 by using Tutor table
        tutor_list_with_conditions = Tutor.all.where(id: tutor_id_only_array).where(location: place).where("experience > #{experieced_or_not}")
     # binding.pry
        if tutor_list_with_conditions.length == 0
            puts "No match. Please try again :("
        else
            Tutor.all.where(id: tutor_id_only_array).where(location: place).where("experience > #{experieced_or_not}")
        end
    end

    # Student W
    def s_write_review
        puts "Please answer follwing questions. You can write reviews for tutors in our platform. Make sure you treat people fairly and as nice as pissbile :)"
        prompt = TTY::Prompt.new
        level = prompt.ask("What is your knowledge level with 5 being highest?")
        email = prompt.ask("What is your tutor email? We need this for validation!") # filterling by name is too weak as there must be a lot of daves, toms for example. email is considered as unique enough
        what_language = prompt.ask("In what language?")
        tutor_rating = prompt.ask("Give a rating please with 5 being highest")
        something_to_say = prompt.ask("Any comment?")

        t_id_by_email = Tutor.all.find_by(contact_email: email) # get the referece for the tutor

        Review.create(student_id: @student_u.id, student_own_level: level, tutor_id: t_id_by_email.id, language: what_language, rating_for_tutor: tutor_rating, comment: something_to_say)
        puts "Thank youfor your review. We always appreciate your feedback!!"
        
        student_profile_screen
    end


    # Student U
    def s_update_profile
        prompt = TTY::Prompt.new
        attr = prompt.select("What information would you lkike to update?", Student.column_names)
    # binding.pry
        if attr == "id" || attr == "created_at" || attr == "updated_at"
            puts "Oops, you can not change it, please select something else"
            s_update_profile
        else 
           new_info = prompt.ask("Please enter the new #{attr}")
           @student_u.update({attr => new_info})
        end
            
        if prompt.yes?('Would you like to update more information?')
           s_update_profile
        else
            student_profile_screen
        end
    end

    # Student D
    def s_delete_profile
        prompt = TTY::Prompt.new
        
        if prompt.yes?("Are you sure you would like to delete to your profile?, This will also delete all of your reviews you made in the past")
           @student_u.reviews.destroy_all # destory reviews(instances in Reviews written by the user) first otherwise we can not find the reviews by the user id. hard delete
           @student_u.destroy
           puts "Thank you for being a great student here! Hope to see you soon again!!"
                    
 # ask moni tomorrow 
 # go_to_exit can not be used as there is no instance after the instance destroied.
        else
           student_profile_screen
        end

        def go_to_exit
            puts "Byebye"
        end
    end



    # end

    # def s_write_review
    #     puts "bababa"
    # end

    # def s_search_tutor
    #     puts "papapa"
    # end
        
    

    

end







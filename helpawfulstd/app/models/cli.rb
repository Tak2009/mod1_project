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
             sleep(10)
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

    def login
        prompt = TTY::Prompt.new
        type = prompt.select("Please, select ", ["Login as Tutor?", "Login as Student?"])
        if type == "Log in as Tutor?"
            login_tutor
        else 
            login_student
        end
    end

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
            puts "Either your email or password is incorrect. Please try again"
            login_student
        end
        
    end

    def student_profile_screen
        prompt = TTY::Prompt.new
        puts "Welcome back, #{@student_u.s_profile_name}!"
        menu = prompt.select("Please, select one of your options!", ["Update Profile", "Write Review", "Search Tutor"])
        if menu == "Update Profile"
            s_update_profile
        elsif menue == "Write Review"
            s_write_review
        else                   # Serch Tutor
            s_search_tutor
        end

    end
    
    # Student U
    def s_update_profile
        prompt = TTY::Prompt.new
        attr = prompt.select("What information would you lkike to update?", Student.column_names)
        if attr == "id"
            puts "Oops, you can not change it, please select something else"
            s_update_profile
        else 
           new_info = prompt.ask("Please enter the new #{attr}")
           @student_u.update({attr => new_info})
        end
            
        if prompt.yes?('Would youlike to update more information?')
           s_update_profile
        else
            student_profile_screen
        end
    end

    def s_write_review
        puts "bababa"
    end

    def s_search_tutor
        puts "papapa"
    end
        
    

    

end







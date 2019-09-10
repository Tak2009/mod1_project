require_relative '../../config/environment'
require 'tty-prompt'

# do NOT use any  variable names which are used as attributes otherwise you will screw up!!!!! >>>> Undefined Class Method!!!
# do NOT use any  variable names which are used as attributes otherwise you will screw up!!!!! >>>> Undefined Class Method!!!
# do NOT use any  variable names which are used as attributes otherwise you will screw up!!!!! >>>> Undefined Class Method!!!
# do NOT use any  variable names which are used as attributes otherwise you will screw up!!!!! >>>> Undefined Class Method!!!

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

    def student_signup
        puts "blablabla"
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
        end
        
    end

    def student_profile_screen
        prompt = TTY::Prompt.new
        puts "Welcome back, #{@student_u.s_profile_name}!"
    end
        
    

    

end







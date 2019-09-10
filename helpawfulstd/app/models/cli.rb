# require_relative '../../config/environment'
# require 'tty-prompt'

#     def run
#         puts "Hello. Please log in or sign up"
#         prompt = TTY::Prompt.new
#         choice = prompt.select("Please, select ", ["Sign up as Student","Sign up as Tutor", "Login", "Exit"])
#         if choice == "Sign up as Student" 
#              student_user 
#         elsif choice == "Sign up as Tutor"
#              tutor_user
#         elsif choice == "Login"
#              login 
#         else 
#              puts "We hope we will see you soon again!" 
#              sleep(1)
#         end 
#     end 

#     def login
#         prompt = TTY::Prompt.new
#         contact_email = prompt.ask("What is your email address??")
#         password = prompt.ask("What is your password??") # I will skip this process
#         if contact_email == Tutor.all.find_by(contact_email: contact_email) 
#              tutor_user_screen
#         elsif contact_email == Student.all.find_by(contact_email: contact_email)
#              student_user_screen
#         else
#              "I can not find your log-in id. Please check"
        
#         # Log in successful
#         puts "Thank you!"
#         sleep(10)
#     end

#     def student_user
#     prompt = TTY::Prompt.new
#     s_profile_name = prompt.ask("What is your profile name?")
#     location = prompt.ask("in which city?")
#     age = prompt.ask("your age?")
#     contact_email = prompt.ask("your contact email?")
#     user = Student.create(s_profile_name: s_profile_name, location: location, age: age, contact_email: contact_email)
#     puts "Thank you. All done now"
#     #    $state["user"] = user 
#     #         questions_interface
#     end







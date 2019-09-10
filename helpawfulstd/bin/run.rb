require_relative '../config/environment'

cli = CLI.new # Need to initialize otherwise instance methods can not be used in cli.rb!!!!
cli.run  # Telling progrramme to start from def run end in cli.rb


# I used to have the setting below.

# ====================================================
# require_relative '../config/environment'
# run 
# ====================================================

# With this setting, my cli file could not pass any variable to other methods.
# cli.rb was not a class file.
# Therefore, to resolve my issue, 1. set a class and 2. write instance methods wioth in the class and hence those instance variables were set so that those varibales can be passed

# class CLI

#     def initialize
#         @student_u = nil
#         @tutor_u = nil
#     end
# end


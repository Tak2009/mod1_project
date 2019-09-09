class Tutor < ActiveRecord::Base
    has_many :reviews
    has_many :students, through: :reviews


    def self.t_create_profile(profile_name, location, language, experience, price, contact_email) # creating a profilr. No duplicate profile name allowed
        tutor = Tutor.find_or_create_by(profile_name: profile_name, language: language) # Tutor can have many languages with one profile and hence 2 arguments must be considered
        tutor.update(location: location)
        tutor.update(language: language)
        tutor.update(experience: experience)
        tutor.update(price: price)
        tutor.update(contact_email: contact_email)
    end


end
    

class Tutor < ActiveRecord::Base
    has_many :reviews
    has_many :students, through: :reviews

    
    # C
    def self.t_create_profile(t_profile_name, location, language, experience, price, contact_email) 
        tutor = Tutor.find_or_create_by(t_profile_name: t_profile_name, language: language, contact_email: contact_email) # Tutor can have many languages. email is added for validation in order to avoid duplicates
        tutor.update(location: location)
        tutor.update(language: language)
        tutor.update(experience: experience)
        tutor.update(price: price)
        tutor.update(contact_email: contact_email)
    end


end
    

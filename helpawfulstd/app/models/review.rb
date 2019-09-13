class Review < ActiveRecord::Base
    belongs_to :student
    belongs_to :tutor
end
    

def self.tutor_names_top10
    
    Review.all.max_by(10) {|r| r.rating_for_tutor}
end
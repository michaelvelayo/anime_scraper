class Character < ActiveRecord::Base
   belongs_to :anime
   belongs_to :role
end

class CareAction < ApplicationRecord
    belongs_to :user
    belongs_to :plant
    belongs_to :action

    
end

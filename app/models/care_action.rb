class CareAction < ApplicationRecord
    belongs_to :user
    belongs_to :plant
    belongs_to :action

# calculates time for care log

    def time_elapsed
        now = DateTime.now
        created = self.created_at
        ((now.to_time - created.to_time) / 60.0).round
    end
end

class User < ApplicationRecord
    has_many :plants
    has_many :care_actions
    has_many :friend_requests, dependent: :destroy
    has_many :pending_friends, through: :friend_requests, source: :friend
    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships

    has_secure_password
    validates :username, presence: true, uniqueness: true
    validates :profile_pic, presence: true

    def remove_friend(friend)
        current_user.friends.destroy(friend)
    end

    def full_name
        self.first_name + " " + self.last_name
    end

    def age
        now = DateTime.now
        created = self.created_at
        age = (now.to_date - created.to_date).to_i
        if age == 1
            "#{age} day old"
        else
            "#{age} days old"
        end
    end
end

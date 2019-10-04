class User < ApplicationRecord
    has_many :friend_requests, dependent: :destroy
    has_many :pending_friends, through: :friend_requests, source: :friend
    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships
    has_many :messages, class_name: "Message", foreign_key: "recipient_id"
    has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"

    has_secure_password
    validates :password, length: { minimum: 6 }, :if => :password
    validates :username, presence: true, uniqueness: true
    validates :profile_pic, presence: true

    has_many :plants
    has_many :care_actions

# removes friend

    def remove_friend(friend)
        current_user.friends.destroy(friend)
    end

# creates full name

    def full_name
        self.first_name + " " + self.last_name
    end

# calculates age

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

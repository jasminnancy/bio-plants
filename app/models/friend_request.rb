class FriendRequest < ApplicationRecord
    belongs_to :user
    belongs_to :friend, class_name: 'User'

    validates :user, presence: true
    validates :friend, presence: true, uniqueness: { scope: :user }
    validate :not_self
    validate :not_friends
    validate :not_pending

# accepts friend requests, adds it to the user's friends and destroys friend request

    def accept
        user.friends << friend
        destroy
    end

    private

# ensures that the user cannot request themselves, isn't already a friend, or doesn't already have a pending request

    def not_self
        errors.add(:friend, "can't be equal to user") if user == friend
    end

    def not_friends
        errors.add(:friend, 'is already added') if user.friends.include?(friend)
    end
    
    def not_pending
        errors.add(:friend, 'already requested friendship') if friend.pending_friends.include?(user)
    end
end

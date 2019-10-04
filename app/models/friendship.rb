class Friendship < ApplicationRecord
    belongs_to :user
    belongs_to :friend, class_name: 'User'

    after_create :create_relationship
    after_destroy :destroy_relationship
    validates :user, presence: true
    validates :friend, presence: true, uniqueness: { scope: :user }
    validate :not_self

    private

# adds friend

    def create_relationship
        friend.friendships.create(friend: user)
    end

# removes friend

    def destroy_relationship
        friendship = friend.friendships.find_by(friend: user)
        friendship.destroy if friendship
    end

# failsafe to ensure user isn't friending themselves

    def not_self
        errors.add(:friend, "can't be equal to user") if user == friend
    end
end

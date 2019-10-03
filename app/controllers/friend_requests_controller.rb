class FriendRequestsController < ApplicationController
    before_action :set_friend_request, except: [:index, :create]
    
    def index
        @incoming = FriendRequest.where(friend: current_user)
        @outgoing = current_user.friend_requests
    end

    def create
        friend = User.find(params[:id])
        @friend_request = current_user.friend_requests.new(friend: friend)
    
        if @friend_request.save
          redirect_to user_path(friend)
        else
          render json: @friend_request.errors, status: :unprocessable_entity
        end
    end

    def update
        @friend_request.accept
        redirect_to friendships_path
    end

    def destroy
        @friend_request.destroy
        redirect_to friendships_path
    end

    private

    def set_friend_request
        @friend_request = FriendRequest.find(params[:id])
    end
end

# index: view incoming and outgoing friend requests
# create: send a friend request to another user
# update: to accept friend requests
# destroy: to decline friend requests
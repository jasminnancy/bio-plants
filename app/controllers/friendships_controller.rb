class FriendshipsController < ApplicationController
    before_action :set_friend, only: :destroy

    ### displays all friends and friend requests ###

    def index
        @user = User.find_by(id: session[:user_id])
        @incoming = FriendRequest.where(friend: current_user)
        @outgoing = current_user.friend_requests
    end

    ### destroys both sides of the friendship - one user cannot be a friend to anothe user that has removed them as a friend ###

    def destroy
        # current_user.remove_friend(@friend)
        first = Friendship.where(user_id: session[:user_id], friend_id: params[:id])
        second = Friendship.where(user_id: params[:id], friend_id: session[:user_id])
        first.destroy_all
        second.destroy_all
        redirect_to friendships_path
    end

    private

    ### finds the correct friend ###

    def set_friend
        @friend = current_user.friends.find(params[:id])
    end
end
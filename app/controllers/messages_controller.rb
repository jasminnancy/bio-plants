class MessagesController < ApplicationController
    before_action :set_recipient, only: [:new, :create]

    def index
        @messages = current_user.messages
    end

    def show
        @messages = current_user.sent_messages
    end

    def new
        @message = current_user.sent_messages.new
    end

    def create
        @message = current_user.sent_messages.new(message_params)
        @message.recipient_id = params[:message][:recipient_id]
        @message.save
        @message.recipient.messages << @message
        redirect_to messages_path
    end

    private

    def message_params
        params.require(:message).permit(:content, :recipient_id, :sender_id)
    end

    def set_recipient
        @recipient = User.find params[:user_id]
    end
end
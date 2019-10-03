class UsersController < ApplicationController
    before_action :authorized, only: [:show, :edit, :update]
    before_action :depreciate, only: [:index, :show]

    def home
    end

    def index
        users = User.where.not(id: session[:user_id])
        @users = users.sort_by { |user| user[:username] }
        @user = User.find_by(id: session[:user_id])
    end

    def show
        @user = User.find_by(id: params[:id])
            if @user == nil
                redirect_to users_path
            end
        @plants = Plant.where(user_id: params[:id])
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        
        if @user.valid?
            @user.save
            plant = Plant.new
            plant.random
            plant.user_id = @user.id
            plant.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def edit
        @user = User.find_by(id: session[:user_id])
    end

    def update
        @user = User.find_by(id: session[:user_id])
        @user.update(user_params)
        redirect_to user_path(@user)
    end

    def destroy
        @user = User.find_by(id: session[:user_id])
        @user.destroy
        session.destroy
        redirect_to '/login'
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :email, :first_name, :last_name, :bio, :profile_pic)
    end

    def depreciate
        plants = Plant.where(user_id: params[:id])
        plants.each do |plant|
            plant.happiness = plant.happiness - plant.elapsed_time
            plant.health = plant.health - plant.elapsed_time
            plant.hunger = plant.hunger - plant.elapsed_time
            plant.save
        end
    end
end

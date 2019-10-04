class UsersController < ApplicationController
    before_action :authorized, only: [:show, :edit, :update]
    before_action :depreciate, only: [:index, :show]

    def home
    end

# lets a user search for other users with the params[:search] function before displaying/sorting results
# if there is no search action performed, it just displays/sorts all users

    def index
        if params[:search]
            @users = User.where('username LIKE ?', "%#{params[:search]}%").order('id DESC')
        else
            @users = User.where.not(id: session[:user_id]).order('id DESC')
        end
        @user = User.find_by(id: session[:user_id])
    end

# displays a specific user and their plants

    def show
        @user = User.find_by(id: params[:id])
            if @user == nil
                redirect_to users_path
            end
        @plants = Plant.where(user_id: params[:id])
    end

# creates a new user with a random-stat generated plant. users cannot exist without a plant!

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

# edits a user's full name, email, pass, profile picture, and bio

    def edit
        @user = User.find_by(id: session[:user_id])
    end

    def update
        @user = User.find_by(id: session[:user_id])
        @user.update(user_params)
        redirect_to user_path(@user)
    end

# destroys a user but not their plants - want to add a greenhouse feature for forfeited plants

    def destroy
        @user = current_user
        @user.destroy
        session.destroy
        redirect_to '/login'
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :email, :first_name, :last_name, :bio, :profile_pic, :search)
    end

# plants depreciate on render to make sure all stats are up-to-date

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

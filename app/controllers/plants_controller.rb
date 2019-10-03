class PlantsController < ApplicationController
    before_action :depreciate, only: [:index, :show]

    def index
        @plants = Plant.where(user_id: session[:user_id])
    end

    def show
        @plant = Plant.find_by(id: params[:id])
        @user = session[:user_id]
    end

    def water
        plant = Plant.find_by(id: params[:id])
        plant.water_plant
        CareAction.create(plant_id: plant.id, user_id: session[:user_id], action_id: 1)
        redirect_to plant_path(plant)
    end

    def feed
        plant = Plant.find_by(id: params[:id])
        plant.feed_plant
        CareAction.create(plant_id: plant.id, user_id: session[:user_id], action_id: 2)
        redirect_to plant_path(plant)
    end

    def sun
        plant = Plant.find_by(id: params[:id])
        plant.sun_plant
        CareAction.create(plant_id: plant.id, user_id: session[:user_id], action_id: 3)
        redirect_to plant_path(plant)
    end

    def new
        @plant = Plant.new
    end

    def create
        @plant = Plant.new(plant_params)
        
        if @plant.save
            redirect_to plant_path(@plant)
        else
            render :new
        end
    end

    def edit
        @plant = Plant.find_by(id: params[:id])
    end

    def update
        @plant = Plant.find_by(id: params[:id])
        if @plant.update(plant_params)
            redirect_to plant_path(@plant)
        else
            render :edit
        end
    end

    private

    def plant_params
        params.require(:plant).permit(:nickname)
    end

    def depreciate
        plant = Plant.find_by(id: params[:id])
        plant.happiness = plant.happiness - plant.elapsed_time
        plant.health = plant.health - plant.elapsed_time
        plant.hunger = plant.hunger - plant.elapsed_time
        plant.save
    end
end
class PlantsController < ApplicationController
    def index
        @plants = Plant.where(user_id: session[:user_id])
    end

    def show
        @plant = Plant.find_by(id: params[:id])
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
        @plant = User.plants.where(user_id: session[:id])
    end

    def update
        @plant = User.plants.where(user_id: session[:id])
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
end
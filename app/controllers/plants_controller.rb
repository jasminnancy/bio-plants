class PlantsController < ApplicationController

    ### shows all of the user's plants + shows a new plant form for propogating ###

    def index
        @plants = Plant.where(user_id: session[:user_id])
        @plants.each { |plant| plant.depreciate }
        @plant = Plant.new
    end

    ### checks to see if a user has less than 6 plants before propogating a new one ###

    def propogate
        if current_user.plants.count < 6
            @plant = Plant.new
            @plant.propogate_random
            @plant.user_id = session[:user_id]
            @plant.save
        end
        redirect_to plant_path(@plant)
    end

    ### shows the plant and depreciates it's stats ###

    def show
        @plant = Plant.find_by(id: params[:id])
        @plant.depreciate
        @user = current_user
    end

    ### workaround for no javascript - care actions are performed by redirecting to a page that ###
    ### performs an action before redirecting back ###

    def water
        plant = Plant.find_by(id: params[:id])
        plant.water_plant
        CareAction.create(plant_id: plant.id, user_id: current_user.id, action_id: 1)
        redirect_to plant_path(plant)
    end

    def feed
        plant = Plant.find_by(id: params[:id])
        plant.feed_plant
        CareAction.create(plant_id: plant.id, user_id: current_user.id, action_id: 2)
        redirect_to plant_path(plant)
    end

    def sun
        plant = Plant.find_by(id: params[:id])
        plant.sun_plant
        CareAction.create(plant_id: plant.id, user_id: current_user.id, action_id: 3)
        redirect_to plant_path(plant)
    end

    ### creates a new plant with random stats ###

    def new
        @plant = Plant.new
    end

    def create
        @plant = Plant.new(user_id: current_user.id)
        @plant.propogate_random(params[:plant][:id])
        
        if @plant.save
            redirect_to plant_path(@plant)
        else
            redirect_to plants_path
        end
    end

    ### allows a user to update the nickname of a plant ###

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
end
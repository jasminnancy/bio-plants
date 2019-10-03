class Plant < ApplicationRecord
    belongs_to :user
    has_many :care_actions
    has_many :actions, through: :care_actions

    validates :nickname, length: { maximum: 13 }

    ### calculates stat total as a percentage (out of 100%) ###

    def stat_total
        (self.health + self.hunger + self.happiness) / 3
    end

    ### details ###

    def age
        now = DateTime.now.in_time_zone('UTC')
        created = self.created_at
        age = (now.to_date - created.to_date).to_i
        if age == 1
            "#{age} day old"
        else
            "#{age} days old"
        end
    end

    def description
        self.name + " - " + self.resilience.to_s
    end

    ### random stat generator for new plant ###

    def random_resilience_generator
        self.resilience = 10.times.sum{ Random.rand(1..13) } 
    end

    def random_plant_type
        plant_types = ["Moss", "Flower", "Fern", "Succulent"]
        plant_types[Random.rand(0..3)]
    end

    def random
        self.name = random_plant_type
        self.resilience = random_resilience_generator
    end

    def propogate_random(prop_plant_id)
        self.name = random_plant_type
        prop_plant = Plant.find_by(id: prop_plant_id)
        sum = (10.times.sum{ Random.rand(1..13) } + prop_plant.resilience) / 2
        self.resilience = sum
    end

    ### actions to improve plant wellness ###

    def random_status_number_generator
        Random.rand(1..10)
    end
    
    def water_plant
        self.health += random_status_number_generator
        if self.health > 100
            self.health = 100
        end
        self.save
    end

    def feed_plant
        self.hunger += random_status_number_generator
        if self.hunger > 100
            self.hunger = 100
        end
        self.save
    end

    def sun_plant
        self.happiness += random_status_number_generator
        if self.happiness > 100
            self.happiness = 100
        end
        self.save
    end

    ### depreciates overall wellness ###

    def elapsed_time
        now = DateTime.now.in_time_zone('UTC')
        updated = self.updated_at
        time = ((now.to_time - updated.to_time) / (self.resilience * 100)).to_i
        (time / (random_status_number_generator * 0.25)).round
    end

    def depreciate
        self.happiness = (self.happiness - self.elapsed_time)
            if self.happiness <= 0
                self.happiness = 0
            end
        self.health = (self.health - self.elapsed_time)
            if self.health <= 0
                self.health = 0
            end
        self.hunger = (self.hunger - self.elapsed_time)
            if self.hunger <= 0
                self.hunger = 0
            end
        self.save
    end

    ### to reset all plants back to 100% happy - used for testing depreciation ###

    # def make_better
    #     self.happiness = 100
    #     self.health = 100
    #     self.hunger = 100
    #     self.save
    # end
end

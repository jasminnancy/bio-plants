class Plant < ApplicationRecord
    belongs_to :user
    has_many :care_actions
    has_many :actions, through: :care_actions

    def random_resilience_generator
        self.resilience = 10.times.sum{ Random.rand(1..13) } 
    end

    def stat_total
        (self.health + self.hunger + self.happiness) / 3
    end

    def age
        now = DateTime.now.in_time_zone('UTC')
        created = self.created_at
        (now.to_date - created.to_date).to_i
    end

    def elapsed_time
        now = DateTime.now.in_time_zone('UTC')
        updated = self.updated_at
        time = ((now.to_time - updated.to_time) / 60).to_i
        (time / random_status_number_generator).round
    end

    def random
        plant_types = ["Moss", "Flower", "Fern", "Succulent"]
        self.name = plant_types[Random.rand(0..3)]
        self.resilience = random_resilience_generator
    end

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
end

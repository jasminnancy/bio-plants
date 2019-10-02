class Plant < ApplicationRecord
    belongs_to :user
    has_many :care_actions
    has_many :actions, through: :care_actions

    def random_resilience_generator
        self.resilience = 10.times.sum{ Random.rand(1..13) } 
    end

    def random_status_number_generator
        Random.rand(1..10)
    end

    def stat_total
        (self.health + self.hunger + self.happiness) / 3
    end

    def age
        now = DateTime.now
        created = self.created_at
        (now.to_date - created.to_date).to_i
    end

    def random
        plant_types = ["Moss", "Flower", "Fern", "Succulent"]
        random_type = plant_types[Random.rand(0..3)]
        self.name = random_type
        self.resilience = random_resilience_generator
    end

    def water
        self.health += random_status_number_generator
        if self.health > 100
            self.health = 100
        end
    end

    def feed
        self.hunger += random_status_number_generator
        if self.hunger > 100
            self.hunger = 100
        end
    end

    def sunshine
        self.happiness += random_status_number_generator
        if self.happiness > 100
            self.happiness = 100
        end
    end
end

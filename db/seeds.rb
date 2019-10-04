# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Action.create(name: "Sunshine", effect: "Increases plant's happiness by up to 10 points.")
Action.create(name: "Water", effect: "Increases plant's health by up to 10 points.")
Action.create(name: "Feed", effect: "Decreases plant's Hunger by up to 10 points.")
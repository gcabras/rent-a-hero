# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'
require 'json'

puts 'Cleaning Database...'
Superhero.destroy_all

api_key = '10226916502772056'

characters = [
  "ironman",
  "america",
  "thor",
  "hulk",
  "widow",
  "hawkeye",
  "witch",
  "vision",
  "falcon",
  "machine",
  "antman",
  "panther",
  "Spider-Man",
  "strange",
  "marvel",
  "cyclops",
  "wolverine",
  "storm",
  "rogue",
  "beast",
  "nightcrawler",
  "colossus",
  "shadowcat",
  "Professor",
  "magneto",
  "mystique"
]

characters.each do |character|
  url = "https://superheroapi.com/api/#{api_key}/search/#{character}"
  p url

  response = URI.open(url).read

  results = JSON.parse(response)

  puts "Creating #{character}..."

  if character == 'marvel'
    superhero = results['results'][1]
  else
    superhero = results['results'].first
  end

  Superhero.create!(
    name: superhero['name'],
    intelligence: superhero['powerstats']['intelligence'].to_i,
    strength: superhero['powerstats']['strength'].to_i,
    speed: superhero['powerstats']['speed'].to_i,
    durability: superhero['powerstats']['durability'].to_i,
    power: superhero['powerstats']['power'].to_i,
    combat: superhero['powerstats']['combat'].to_i,
    full_name: superhero['biography']['full-name'],
    place_of_birth: superhero['biography']['place-of-birth'],
    alignment: superhero['biography']['alignment'],
    race: superhero['appearance']['race'],
    occupation: superhero['work']['occupation'],
    base: superhero['work']['base'],
    affiliation: superhero['connections']['group-affiliation'],
    image_url: superhero['image']['url']
  )
end

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
User.destroy_all

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

User.create!(email: 'nicholasfury@rent-a-hero.com', password: 'avengers')
places = capital_cities = [
  { city: "Montgomery", state: "Alabama" },
  { city: "Juneau", state: "Alaska" },
  { city: "Phoenix", state: "Arizona" },
  { city: "Little Rock", state: "Arkansas" },
  { city: "Sacramento", state: "California" },
  { city: "Denver", state: "Colorado" },
  { city: "Hartford", state: "Connecticut" },
  { city: "Dover", state: "Delaware" },
  { city: "Tallahassee", state: "Florida" },
  { city: "Atlanta", state: "Georgia" },
  { city: "Honolulu", state: "Hawaii" },
  { city: "Boise", state: "Idaho" },
  { city: "Springfield", state: "Illinois" },
  { city: "Indianapolis", state: "Indiana" },
  { city: "Des Moines", state: "Iowa" },
  { city: "Topeka", state: "Kansas" },
  { city: "Frankfort", state: "Kentucky" },
  { city: "Baton Rouge", state: "Louisiana" },
  { city: "Augusta", state: "Maine" },
  { city: "Annapolis", state: "Maryland" },
  { city: "Boston", state: "Massachusetts" },
  { city: "Lansing", state: "Michigan" },
  { city: "St. Paul", state: "Minnesota" },
  { city: "Jackson", state: "Mississippi" },
  { city: "Jefferson City", state: "Missouri" },
  { city: "Helena", state: "Montana" },
  { city: "Lincoln", state: "Nebraska" },
  { city: "Carson City", state: "Nevada" },
  { city: "Concord", state: "New Hampshire" },
  { city: "Trenton", state: "New Jersey" },
  { city: "Santa Fe", state: "New Mexico" },
  { city: "Albany", state: "New York" },
  { city: "Raleigh", state: "North Carolina" },
  { city: "Bismarck", state: "North Dakota" },
  { city: "Columbus", state: "Ohio" },
  { city: "Oklahoma City", state: "Oklahoma" },
  { city: "Salem", state: "Oregon" },
  { city: "Harrisburg", state: "Pennsylvania" },
  { city: "Providence", state: "Rhode Island" },
  { city: "Columbia", state: "South Carolina" },
  { city: "Pierre", state: "South Dakota" },
  { city: "Nashville", state: "Tennessee" },
  { city: "Austin", state: "Texas" },
  { city: "Salt Lake City", state: "Utah" },
  { city: "Montpelier", state: "Vermont" },
  { city: "Richmond", state: "Virginia" },
  { city: "Olympia", state: "Washington" },
  { city: "Charleston", state: "West Virginia" },
  { city: "Madison", state: "Wisconsin" },
  { city: "Cheyenne", state: "Wyoming" }
]

characters.each do |character|
  url = "https://superheroapi.com/api/#{api_key}/search/#{character}"
  p url

  response = URI.open(url).read

  results = JSON.parse(response)

  if character == 'marvel' || character == 'strange' || character == 'thor'
    superhero = results['results'][1]
  else
    superhero = results['results'].first
  end

  puts "Creating #{superhero['name']}..."

  superhero = Superhero.new(
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
  if superhero.latitude.nil? && superhero.longitude.nil?
    address = places.sample
    superhero.base = "#{address[:city]}, #{address[:state]}"
  end
  superhero.save!
  superhero.update(latitude: superhero.latitude + [0.1, 0.3, 0.9].sample)
  superhero.save!
end

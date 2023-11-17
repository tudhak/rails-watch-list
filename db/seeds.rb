# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'open-uri'

Movie.destroy_all


results = JSON.parse(URI.open('http://tmdb.lewagon.com/movie/top_rated').read)['results']

results.each do |result|
  Movie.create(
    title: result['title'],
    overview: result['overview'],
    rating: result['vote_average'],
    poster_url: "https://image.tmdb.org/t/p/w500#{result['backdrop_path']}"
  )
end

# 10.times do
  # Movie.create(title: Faker::Movie.title, overview: Faker::Movie.quote,
  #              poster_url: Faker::Avatar.image, rating: rand(9.9))
# end

puts 'Seed successfully generated.'

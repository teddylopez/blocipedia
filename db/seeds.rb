require 'random_data'

# Create Wikis
50.times do
  Wiki.create!(
    title:  Faker::ChuckNorris.fact,
    body:   Faker::ChuckNorris.fact
  )
end
wikis = Wiki.all

puts "Seed finished"
puts "#{Wiki.count} wikis created"

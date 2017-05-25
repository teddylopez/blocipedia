require 'random_data'

# Create Wikis
5.times do
  Wiki.create!(
    title:  Faker::ChuckNorris.fact,
    body:   Faker::ChuckNorris.fact
  )
end
wikis = Wiki.all

#Create a standard member
standard = User.new(
    email:      'standard@bpedia.com',
    password:   'password',
    role:       'standard'
)
standard.skip_confirmation!
standard.save!

# Create a premium member
premium = User.new(
    email:      'premium@bpedia.com',
    password:   'password',
    role:       'premium'
)
premium.skip_confirmation!
premium.save!

# Create an admin
admin = User.new(
    email:      'admin@bpedia.com',
    password:   'password',
    role:       'admin'
)
admin.skip_confirmation!
admin.save!

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"

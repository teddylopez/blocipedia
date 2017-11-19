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
    role:       'admin',
    admin:      true
)
admin.skip_confirmation!
admin.save!

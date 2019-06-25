user = User.find_or_create_by(email: 'example@maap.tld') do |u|
  u.password = 'password'
end
AdminUser.create(email: 'admin@maap.tld', password: 'password', password_confirmation: 'password')

FactoryBot::create_list(:lab, 10 - Lab.count)

# Patch for devise token auth model. 
# It's only needed if you are in the context of the initial migration for uses
User.find(user.id).update(tokens: nil)

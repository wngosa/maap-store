user = User.find_or_create_by(email: 'example@maap.tld') do |u|
  u.password = 'password'
end
puts 'Created user'
puts user

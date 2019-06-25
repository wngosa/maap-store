user = User.find_or_create_by(email: 'example@maap.tld') do |u|
  u.password = 'password'
  u.tokens = nil
end
AdminUser.create(email: 'admin@maap.tld', password: 'password', password_confirmation: 'password')
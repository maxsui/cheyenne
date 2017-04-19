# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.find_or_create_by!(email: 'admin@example.com') do |admin|
  generated_password = SecureRandom.hex
  puts "Admin password: #{generated_password}"
  admin.password = generated_password
end

if Observable.count == 0
  observables = File.readlines(File.expand_path('../seeds-observables.csv', __FILE__))
  observables.each do |name|
    Observable.find_or_create_by!(name: name)
  end
end

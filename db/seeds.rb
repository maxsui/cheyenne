# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

if Observable.count == 0
  puts "✓ Create observables"
  rows = CSV.read(File.expand_path('../seeds-observables.csv', __FILE__))
  rows.each do |row|
    name = row.first
    Observable.find_or_create_by!(name: name)
  end
end

if Goal.count == 0
  puts "✓ Create goals"
  rows = CSV.read(File.expand_path('../seeds-goals.csv', __FILE__))
  rows.each do |name, category_name|
    Goal.find_or_create_by!(name: name) do |goal|
      goal.goal_category = GoalCategory.find_or_create_by!(name: category_name)
    end
  end
end

User.find_or_create_by!(email: 'admin@example.com') do |admin|
  puts "✓ Create default user"
  generated_password = SecureRandom.hex
  puts "Admin password: #{generated_password}"
  admin.password = generated_password
end

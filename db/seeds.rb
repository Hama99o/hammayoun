# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)




# Create 50 tags
50.times { FactoryBot.create(:tag) }

# Create 3 users
users = FactoryBot.create_list(:user, 3)

users.push(FactoryBot.create(:user, firstname: 'hama', lastname: 'safi', email: 'hmmshl@gmail.com')) if User.where(email: 'hmmshl@gmail.com').blank?

# Create 10 notes for each user
users.each do |user|
  FactoryBot.create_list(:note, 10, owner: user)
end

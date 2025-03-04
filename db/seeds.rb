# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 1. Clean the database 🗑️
puts "Cleaning database..."
Software.destroy_all
User.destroy_all

test = User.create!(first_name: "test", last_name:"test", username:"test",email:"test@test.com",password:"test12345")

100.times do
  Software.create!(name:Faker::Company.name,
              price_month:(50..150).to_a.sample,
              description:Faker::Quotes::Shakespeare.hamlet_quote,
              tag:Faker::Company.industry,
              user: test)
end


# 3. Display a message 🎉
puts "Finished! Created #{Software.count} softwares."

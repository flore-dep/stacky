require "open-uri"

puts "Cleaning database..."
Software.destroy_all
User.destroy_all

test = User.create!(
  first_name: "test",
  last_name: "test",
  username: "test",
  email: "test@test.com",
  password: "test12345"
)

cloudinary_url = "https://res.cloudinary.com/dse45apre/image/upload/v1741094002/stacky/development/p3nsjpxlej0g98azpbyudm1orib0.jpg"
file = URI.open(cloudinary_url)

6.times do
  software = Software.create!(
    name: Faker::Company.name,
    price_month: (50..150).to_a.sample,
    description: Faker::Quotes::Shakespeare.hamlet_quote,
    tag: Faker::Company.industry,
    user: test
  )

  # ⚠️ Ouvrir un nouveau fichier à chaque fois pour éviter les erreurs
  software.logo.attach(io: file, filename: "default_logo.jpg", content_type: "image/jpeg")
  puts "Created the ressource"
end

puts "Finished! Created #{Software.count} softwares."

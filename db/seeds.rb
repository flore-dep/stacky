require "open-uri"

puts "Cleaning database..."
Review.destroy_all
License.destroy_all
Software.all.each { |software| software.logo.purge_later } # Supprime les fichiers attachés
Software.destroy_all
User.destroy_all

flore = User.create!(first_name: "flore", last_name: "imichon", username: "fleurimichon", email: "flore@test.com", password: "test12345")
vic = User.create!(first_name: "victor", last_name: "hugo", username: "vhugo", email: "victor@test.com", password: "test12345")
jean = User.create!(first_name: "jean", last_name: "valjean", username: "jval", email: "jean@test.com", password: "test12345")
romain = User.create!(first_name: "romin", last_name: "desmois", username: "rdesm", email: "romain@test.com", password: "test12345")

users = [flore, vic, jean, romain]
urls = [
  "https://res.cloudinary.com/dse45apre/image/upload/v1741096793/630146f6684f52c4df294af9_Aircall_-_VoIP_Business_Phone_-_Apps_on_Google_Play_z468yk.png",
  "https://res.cloudinary.com/dse45apre/image/upload/v1741096793/unnamed_muqnqs.png",
  "https://res.cloudinary.com/dse45apre/image/upload/v1741096793/te%CC%81le%CC%81chargement_2_g1i7sm.png"
]

cloudinary_url = "https://res.cloudinary.com/dse45apre/image/upload/v1741094002/stacky/development/p3nsjpxlej0g98azpbyudm1orib0.jpg"
file = URI.open(cloudinary_url)

softwares_init = []

urls.each do |url|
  software_init = Software.create!(
    name: Faker::Company.name,
    price_month: (50..150).to_a.sample,
    description: Faker::Quotes::Shakespeare.hamlet_quote,
    tag: Faker::Company.industry,
    user: users.sample
  )
  file = URI.open(url)
  software_init.logo.attach(io: file, filename: "default_logo.jpg", content_type: "image/jpeg")
  softwares_init << software_init
end


10.times do
  software = Software.create!(
    name: Faker::Company.name,
    price_month: (50..150).to_a.sample,
    description: Faker::Quotes::Shakespeare.hamlet_quote,
    tag: Faker::Company.industry,
    user: users.sample
  )

  sample_attributes = softwares_init.sample.logo.attachments.first.attributes
  sample_attributes.delete("id")&&sample_attributes.delete("created_at")
  sample_attributes["record_id"] = software.id
  ActiveStorage::Attachment.create!(sample_attributes)
end

Software.all.each do |software|
  license = License.new(start_at: "2025-01-01" ,end_at: "2025-03-01")
  license.software = software
  license.user = users.sample
  license.save
end

License.all.each do |license|
  Review.create!(comment: Faker::Quotes::Shakespeare.hamlet_quote, rating: (0..5).to_a.sample, license: license)
end

puts "Finished! Created #{Software.count} softwares."

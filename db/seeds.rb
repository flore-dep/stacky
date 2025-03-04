require "open-uri"

puts "Cleaning database..."
Software.all.each { |software| software.logo.purge_later } # Supprime les fichiers attachés
Software.destroy_all
User.destroy_all

test = User.create!(
  first_name: "test",
  last_name: "test",
  username: "test",
  email: "test@test.com",
  password: "test12345"
)

urls = [
  "https://res.cloudinary.com/dse45apre/image/upload/v1741096793/630146f6684f52c4df294af9_Aircall_-_VoIP_Business_Phone_-_Apps_on_Google_Play_z468yk.png",
  "https://res.cloudinary.com/dse45apre/image/upload/v1741096793/unnamed_muqnqs.png",
  "https://res.cloudinary.com/dse45apre/image/upload/v1741096793/te%CC%81le%CC%81chargement_2_g1i7sm.png"
]

cloudinary_url = "https://res.cloudinary.com/dse45apre/image/upload/v1741094002/stacky/development/p3nsjpxlej0g98azpbyudm1orib0.jpg"
file = URI.open(cloudinary_url)

softwares_init = []

urls.each do |url|
  puts "new url : #{url}"
  software_init = Software.create!(
    name: Faker::Company.name,
    price_month: (50..150).to_a.sample,
    description: Faker::Quotes::Shakespeare.hamlet_quote,
    tag: Faker::Company.industry,
    user: test
  )
  file = URI.open(url)
  software_init.logo.attach(io: file, filename: "default_logo.jpg", content_type: "image/jpeg")
  softwares_init << software_init
  puts software_init
end

puts softwares_init
# software_init = Software.create!(
#   name: Faker::Company.name,
#   price_month: (50..150).to_a.sample,
#   description: Faker::Quotes::Shakespeare.hamlet_quote,
#   tag: Faker::Company.industry,
#   user: test
# )
# software_init.logo.attach(io: file, filename: "default_logo.jpg", content_type: "image/jpeg")
# attributes = software_init.logo.attachments.first.attributes


10.times do
  software = Software.create!(
    name: Faker::Company.name,
    price_month: (50..150).to_a.sample,
    description: Faker::Quotes::Shakespeare.hamlet_quote,
    tag: Faker::Company.industry,
    user: test
  )

  sample_attributes = softwares_init.sample.logo.attachments.first.attributes
  sample_attributes.delete("id")&&sample_attributes.delete("created_at")
  sample_attributes["record_id"] = software.id
  puts "new attributes #{sample_attributes}"
  ActiveStorage::Attachment.create!(sample_attributes)
end

puts "Finished! Created #{Software.count} softwares."

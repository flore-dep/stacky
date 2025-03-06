require "open-uri"
require "csv"

TAG_LIST = [
  "International",
  "Produit",
  "Administratif & Juridique",
  "Business",
  "Financements",
  "RH",
  "Tech",
  "Stratégie",
  "Autre",
  "CSM",
  "Marketing & Communication",
  "Collaboration & Management"
]

puts "Cleaning database..."
SoftwareTag.destroy_all
TeamTag.destroy_all
CategoryTag.destroy_all
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

# category_tag_productivity = CategoryTag.create!(name: "Productivity", color:)
# category_tag_projectmanagement  = CategoryTag.create!(name: "Project Management", color:)
# category_tag_communication  = CategoryTag.create!(name: "Communication", color:)
# category_tag_crm  = CategoryTag.create!(name: "CRM", color:)
# category_tag_businessintelligence  = CategoryTag.create!(name: "Business Intelligence", color:)
# category_tag_automation  = CategoryTag.create!(name: "Automation", color:)



filepath = File.expand_path("data_seed.csv", __dir__)

CSV.foreach(filepath) do |row|
  software = Software.create!(
    name: row[0],
    price_month: (50..150).to_a.sample,
    description: row[1],
    long_description: row[2],
    website: row[3],
    tag: TAG_LIST.sample(rand(1..3)),
    user: users.sample
  )
  file = URI.open(row[4])
  software.logo.attach(io: file, filename: "default_logo.jpg", content_type: "image/jpeg")
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

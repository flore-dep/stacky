require "open-uri"
require "csv"

puts "Cleaning database..."
SoftwareTag.destroy_all
TeamTag.destroy_all
CategoryTag.destroy_all
Review.destroy_all
License.destroy_all
Software.all.each { |software| software.logo.purge_later } # Supprime les fichiers attachés
Software.destroy_all
User.destroy_all

puts "Creating users..."
flore = User.create!(first_name: "flore", last_name: "imichon", username: "fleurimichon", email: "flore@test.com", password: "test12345")
vic = User.create!(first_name: "victor", last_name: "hugo", username: "vhugo", email: "victor@test.com", password: "test12345")
jean = User.create!(first_name: "jean", last_name: "valjean", username: "jval", email: "jean@test.com", password: "test12345")
romain = User.create!(first_name: "romin", last_name: "desmois", username: "rdesm", email: "romain@test.com", password: "test12345")
users = [flore, vic, jean, romain]

puts "Creating category tags..."
category_tag_productivity = CategoryTag.create!(name: "Productivity", color: "category-productivity")
category_tag_projectmanagement  = CategoryTag.create!(name: "Project Management", color: "category-projectmanagement")
category_tag_communication  = CategoryTag.create!(name: "Communication", color: "category-communication")
category_tag_crm  = CategoryTag.create!(name: "CRM", color: "category-crm")
category_tag_businessintelligence  = CategoryTag.create!(name: "Business Intelligence", color: "category-businessintelligence")
category_tag_automation  = CategoryTag.create!(name: "Automation", color: "category-automation")

puts "Creating team tags..."
team_tag_product = TeamTag.create!(name: "Product", color: "team-tag")
team_tag_data = TeamTag.create!(name: "Data", color: "team-tag")
team_tag_tech = TeamTag.create!(name: "Tech", color: "team-tag")
team_tag_admin  = TeamTag.create!(name: "Admin", color: "team-tag")
team_tag_sales  = TeamTag.create!(name: "Sales", color: "team-tag")
team_tag_accounting  = TeamTag.create!(name: "Accounting", color: "team-tag")
team_tag_marketing  = TeamTag.create!(name: "Marketing", color: "team-tag")
team_tag_communication  = TeamTag.create!(name: "Communication", color: "team-tag")
team_tag_hr = TeamTag.create!(name: "HR", color: "team-tag")
puts "Creating softwares..."
filepath = File.expand_path("data_seed.csv", __dir__)

CSV.foreach(filepath) do |row|
  puts "#{row[0]}"
  software = Software.create!(
    name: row[0],
    price_month: (50..150).to_a.sample,
    description: row[1],
    tag: Software::TAG_LIST.sample(rand(1..3)),
    category: Software::CATEGORIES.sample,
    long_description: row[2],
    website: row[3],
    address: row[5],
    user: users.sample
  )
  begin
    file = URI.open(row[4])
    software.logo.attach(io: file, filename: "default_logo.jpg", content_type: "image/jpeg")
  rescue OpenURI::HTTPError, Errno::ENOENT => e
    puts "⚠️ Erreur lors du téléchargement du logo pour #{row[0]}: #{e.message}"
    next # Passe à la ligne suivante
  end
  SoftwareTag.create!(software: software, category_tag: CategoryTag.all.sample)

  team_tags = TeamTag.all.sample(rand(1..3))
  team_tags.each do |tag|
    SoftwareTag.create!(software: software, team_tag: tag)
  end
end

puts "Creating licenses..."
Software.all.each do |software|
  license = License.new(start_at: "2025-01-01" ,end_at: "2025-03-01")
  license.software = software
  license.user = users.sample
  license.save
end

puts "Creating reviews..."
License.all.each do |license|
  10.times do
    Review.create!(comment: Faker::Quotes::Shakespeare.hamlet_quote, rating: (0..5).to_a.sample, license: license)
  end
end

puts "Finished! Created #{Software.count} softwares."

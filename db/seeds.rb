# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'factory_bot_rails'

Rails.logger.debug 'Seeds running...'

# Seed Products
[
  'One Fish',
  'Two Fish',
  'Red Fish',
  'Blue Fish'
].each_with_index do |fish_name, i|
  FactoryBot.create(:product, name: fish_name, price: (10 * (10 + i)))
end

Rails.logger.debug 'Seeds done :ta-da:'

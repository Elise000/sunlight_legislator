require 'byebug'
require_relative 'db/config'
require_relative 'app/models/legislator'
require_relative 'lib/sunlight_legislators_importer.rb'


puts "Putting results"
p Legislator.where(state: "NY")
puts "...................................."

# p Legislator.where(state: "NY", title: "Sen").limit(2)
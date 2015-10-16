require_relative 'app/models/legislator'
require_relative 'app'

# puts "Putting results"
# p Legislator.where(state: "NY")
# puts "...................................."

# p Legislator.where(state: "NY", title: "Sen").limit(2)

p Legislator.bystate("NY", "Sen")

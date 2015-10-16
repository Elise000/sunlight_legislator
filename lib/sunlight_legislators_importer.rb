require 'csv'
require_relative '../app'

class SunlightLegislatorsImporter
  def self.import(filename)
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      row.each do |field, value|

        Legislator.create field.to_sym => value
        # byebug
        # raise NotImplementedError, "TODO: figure out what to do with this row and do it!"
        # TODO: end
      end
    end
  end
end



  #   cohort_names = %w(Alpha Beta Delta Gamma Epsilon Zeta Eta Theta Iota)

  #   cohort_ids = cohort_names.map do |name|
  #     Cohort.create(:name => name)[:id]
  #   end

  #   2000.times do
  #     Student.create :first_name => Faker::Name.first_name,
  #                    :last_name  => Faker::Name.last_name,
  #                    :email      => Faker::Internet.email,
  #                    :birthdate  => Date.today - rand(15..40)*365,
  #                    :gender     => ['m', 'f'].sample,
  #                    :cohort_id  => cohort_ids.sample
  #   end
  # end


# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end

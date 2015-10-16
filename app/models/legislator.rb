
require_relative '../../db/config'
require 'byebug'

class Legislator < ActiveRecord::Base


  validates :phone, :format => { :with => /\A\d{3}\D\d{3}\D\d{4}\z/, :message => "error phone"}

  def self.check(term, arg)
    self.where("#{term} = ?", arg)
  end

  # def self.bystate(state, title)
  #   self.where(state: state, title: title).limit(2)
  # end

  def self.bystate(state, arg)
    a = self.where("#{state} = ?", arg)

    senators = a.where(title: "Sen").order(:lastname)

    puts "Senators:"
    senators.all.each do |x|
      puts x.firstname + " " + x.lastname + " " + "(#{x.party})"
    end

  puts ".................................."
    rep = a.where(title: "Rep").order(:lastname)

    puts "Representatives:"
    rep.all.each do |x|
      puts x.firstname + " " + x.lastname + " " + "(#{x.party})"
    end
  end

  def self.list(term1, term2, arg)

     self.where(["#{term1} = ? and #{term2} = ?", arg[0], arg[1]])

  end

  def self.list3(term1, term2, term3, arg)

      a = self.where(["#{term1} = ? and #{term2} = ? and #{term3}=?", arg[0], arg[1],arg[2]])

      a.all.each do |x|
       puts x.party + " " + x.title + " " + x.in_office
       end
  end

  def self.bygender?(arg)
      a = self.where(in_office: "1")
      sen_count = a.where(title: "Sen").all.count
      rep_count = a.count - sen_count
      gender_sen_cnt = a.where("gender = ? and title = ?", arg, "Sen").count
      percent = (gender_sen_cnt/sen_count.to_f) * 100

      gender_rep_cnt = a.where("gender = ? and title = ?", arg, "Rep").count
      percentage = (gender_rep_cnt/rep_count.to_f) * 100

      if arg == "M"
        puts "Male Senators: " + gender_sen_cnt.to_s + "(#{percent}%)"
        puts "Male Representatives: " + gender_rep_cnt.to_s + "(#{percentage}%)"
      else
        puts "Female Senators: " + gender_sen_cnt.to_s + "(#{percent}%)"
        puts "Female Representatives: " + gender_rep_cnt.to_s + "(#{percentage}%)"
      end
  end

  def self.at_office?(term, arg)

      a = self.where("#{term}=?", arg).sample

      if a.in_office == "1"
        puts "#{a.firstname} is in office"
        return true
      else
        puts "#{a.firstname} is out"
        return false
      end
  end

  def self.list_all
    # num = 0
    a = self.where(in_office: "1")
    # puts a.count
    arr = a.uniq.pluck(:state)

    new_arr = []

    arr.each do |x|
      sen_count = a.where(title: "Sen", state: x).count
      rep_count = a.where(title: "Rep", state: x).count
      # num += (sen_count + rep_count)
      if sen_count > 0 && rep_count > 0
        new_arr << [x , sen_count, rep_count]
      end
        # puts "#{x}:  " + sen_count.to_s + " Senators, " + rep_count.to_s + " " + "Representatives(s)"
    end

    sorted_arr = new_arr.sort{|a, b| b[2]<=> a[2]}

    sorted_arr.each do |element|
      puts "#{element[0]}:  " + element[1].to_s + " Senators, " + element[2].to_s + " " + "Representatives(s)"
    end
  end

  def self.count
    sen_count = self.where(title:"Sen").all.count
    rep_count = self.where(title:"Rep").all.count

    puts "Senators:   " + sen_count.to_s
    puts "Representatives:   " + rep_count.to_s

  end

  def self.delete
    puts "All records: " + self.all.count.to_s
    puts self.where(in_office: "0").count.to_s
    self.destroy_all(in_office: "0")

    puts
    puts "All records after delete: " + self.all.count.to_s
  end
end



# attr_accessor :first_name, :last_name, :birthday

  # validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :message => "error"}

  # validates :email, :uniqueness => true

  # validates :age, :numericality => {:greater_than => 4}

  # validates :phone, :format => { :with => /\D\d{3}\D{2}\d{3}\D\d{4}\D{2}\d{4}/, :message => "error phone"}



  # def name
  #   self.first_name + " " + self.last_name
  # end

  # def age
  #   now = Date.today
  #   age = now.year - self.birthday.year
  #   # - ((now.month > self.birthday.month || (now.month == self.birthday.month && now.day >= self.birthday.day)) ? 0 : 1)
  #   return age
  # end
# implement your Student model here


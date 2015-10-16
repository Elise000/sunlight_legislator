
require_relative '../../db/config'
require 'byebug'

class Legislator < ActiveRecord::Base

  def self.check(term, arg)

    self.where("#{term} = ?", arg)

  end

  def self.bystate(state, title)

    self.where(state: state, title: title).limit(2)

  end

  def self.list(term1, term2, arg)

     self.where(["#{term1} = ? and #{term2} = ?", arg[0], arg[1]])

  end

  def self.list(term1, term2, term3, arg)

      a = self.where(["#{term1} = ? and #{term2} = ? and #{term3}=?", arg[0], arg[1],arg[2]])

      a.all.each do |x|
       puts x.party + " " + x.title + " " + x.in_office
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

end
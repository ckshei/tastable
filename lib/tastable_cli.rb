# require "tastable/version"
require_relative 'restaurants.rb'
require_relative 'user.rb'
require 'faraday'
require 'json'
require 'pry'

class Cli

  attr_accessor :user, :index

  def run
    puts "Welcome to Tastable - a cli that helps you make same day reservations at nearby restaurants"

    puts "Where are you located? (enter your zipcode)"

    zip = gets.strip

    puts "How many in your party (enter 1-6)"

    party_size = gets.strip

    @user = User.new(zip, party_size)
    
    puts "\nHere are a list of nearby restaurants with reservations availabile today"
    puts "For more information, type in an index number (e.g. 1)"
    self.print_restaurant_objects
  end

  def print_restaurant_objects
    @user.restaurant_objects.each.with_index(1) do |res, i|
      puts "#{i}. #{res.name}"
    end
    self.more_info
  end

  def more_info
    @index = gets.to_i - 1
    if @index.between?(0,user.restaurant_objects.length-1)
      @user.restaurant_objects[index].get_more_info
      puts "Type res to make a reservation, back to go back, and more for more reservation times"
      action
    else
      puts "\nInvalid entry - please try again:"
      puts "For more information, type in an index number (e.g. 1)"
      self.print_restaurant_objects
    end
  end

  def action
      action = gets.strip
    if action == "res"
      self.res
    elsif action == "back"
      self.print_restaurant_objects
    elsif action == "more"
      @user.restaurant_objects[index].more_reservation_times(user.party_size)
    else
      puts "invalid entry - please try again"
      puts "Type res to make a reservation, back to go back, and more for more reservation times"
      self.action(index)
    end
  end

  def res
    puts @user.restaurant_objects[@index].make_reservation
  end
      

end

Cli.new.run
# binding.pry
# require "tastable/version"
require_relative 'restaurants.rb'
require_relative 'user.rb'
require 'faraday'
require 'json'
require 'pry'

class Cli

  attr_accessor :user

  def run
    puts "Welcome to Tastable - a cli that helps you make same day reservations at nearby restaurants"

    puts "First, where are you located (enter your zipcode)"

    zip = gets.strip

    puts "How many in your party (enter 1-6)"

    party_size = gets.strip

    @user = User.new(zip, party_size)
    
    puts "Here are a list of nearby restaurants with reservations availabile today"
    puts "Type in the index for more information on any specific restaurant (e.g. 1)"
    self.print_restaurant_objects

    index = gets.to_i
    binding.pry
    user.restaurant_objects[index].get_more_info
    binding.pry

    puts "Type 'res' to make a reservation, 'more' for more reservation times, and 'back' to go back"
  end

  def print_restaurant_objects
    @user.restaurant_objects.each.with_index(1) do |res, i|
      # binding.pry
      puts "#{i}. #{res.name}"
    end

  end

end

Cli.new.run
# binding.pry
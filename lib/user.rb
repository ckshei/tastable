# require "tastable/version"
require_relative 'restaurants.rb'
require 'faraday'
require 'json'
require 'pry'

module Tastable
  class User

    attr_accessor :zipcode, :party_size, :nearby_restaurants, :restaurant_objects

    def initialize(zipcode, party_size)
      @zipcode = zipcode
      @party_size = party_size
      @restaurant_objects = []
      self.get_nearby_restaurants
      self.create_restaurant_objects
    end

    def get_nearby_restaurants
      conn = Faraday.new(:url => 'https://opentable.herokuapp.com') do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
      faraday_object = conn.get '/api/restaurants', {:zip => self.zipcode, :per_page => 15}
      # binding.pry
      hash = JSON.parse(faraday_object.body)
      @nearby_restaurants = hash["restaurants"]
    end

    def create_restaurant_objects
      puts "\nloading restaurants near you..."
      @nearby_restaurants.each do |restaurant|
        begin
          new_restaurant = Restaurant.new(restaurant["mobile_reserve_url"], @party_size)
          if new_restaurant.reservation_times.length != 0
            @restaurant_objects << new_restaurant
          end
        rescue
          next
        end
      end
    end
  end

end
user1 = Tastable::User.new(11211,3)
binding.pry

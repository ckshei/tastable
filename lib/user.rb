# require "tastable/version"
require 'faraday'
require 'json'
require 'pry'

module Tastable
  class User

    attr_accessor :zipcode, :party_size, :nearby_restaurants

    def initialize(zipcode, party_size)
      @zipcode = zipcode
      @party_size = party_size
    end

    def get_nearby_restaurants
      conn = Faraday.new(:url => 'https://opentable.herokuapp.com') do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
      faraday_object = conn.get '/api/restaurants', {:zip => self.zipcode }
      # binding.pry
      hash = JSON.parse(faraday_object.body)
      @nearby_restaurants = hash["restaurants"]
    end
  end

end
user1 = Tastable::User.new(11211,3)
binding.pry

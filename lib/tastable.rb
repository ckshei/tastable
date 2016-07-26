# require "tastable/version"
require 'faraday'
require 'json'
require 'pry'

module Tastable
  class Restaurant_hash

    def get(zipcode)
      conn = Faraday.new(:url => 'https://opentable.herokuapp.com') do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
      faraday_object = conn.get '/api/restaurants', {:zip => zipcode }
      # binding.pry
      hash = JSON.parse(faraday_object.body)
      restaurants = hash["restaurants"]
      binding.pry
    end
  end

end
object = Tastable::Restaurant_hash.new
binding.pry

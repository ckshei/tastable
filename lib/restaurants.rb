# require "tastable/version"
require 'pry'
require 'nokogiri'
require 'open-uri'

class Restaurant

  attr_reader :link, :doc
  attr_accessor :cuisine, :description, :res_times

  def initialize(link)
    @link = link
    @doc = Nokogiri::HTML(open(link))
    @cuisine = doc.css('div#ft').css('.dot-before').text
    @description = doc.css('div#DescriptionText').text
    @reservation_times = []
    doc.css('div.col-xs-12 div#restaurantAvailabilityResults div#ulSlots a span').each do |x|
      reservation_times << x.text
    end
  end

end

binding.pry

# # module Tastable
# doc = Nokogiri::HTML(open("https://m.opentable.com/restaurants/scalini-fedeli/6417?PartySize=6"))
# cuisine = doc.css('div#ft').css('.dot-before').text
# description = doc.css('div#DescriptionText').text
# reservation_times = []
# doc.css('div.col-xs-12 div#restaurantAvailabilityResults div#ulSlots a span').each do |x|
#   reservation_times << x.text
# end
# binding.pry

# # end
# object = Tastable::Restaurant_hash.new
# binding.pry

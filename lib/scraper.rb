# require "tastable/version"
require 'pry'
require 'nokogiri'
require 'open-uri'

# module Tastable
doc = Nokogiri::HTML(open("https://m.opentable.com/restaurants/zuni-cafe/4485"))
cuisine = doc.css('div#ft').css('.dot-before').text
description = doc.css('div#DescriptionText').text
reservation_times = []
doc.css('div.col-xs-12 div#restaurantAvailabilityResults div#ulSlots span').each do |x|
  reservation_times << x.text
end
binding.pry

# end
object = Tastable::Restaurant_hash.new
binding.pry

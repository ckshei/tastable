# require "tastable/version"
require 'pry'
require 'nokogiri'
require 'open-uri'
class Restaurant

  attr_accessor :link, :cuisine, :description, :reservation_times, :reservation_today

  def initialize(link, party_size)
    # binding.pry
    @link = link.gsub(/http/, 'https') #necessary to prevent redirect forbidden error
    @link = @link << "&PartySize=#{party_size}"
    # binding.pry
    doc = Nokogiri::HTML(open(@link))
    @cuisine = doc.css('div#ft').css('.dot-before').text
    @description = doc.css('div#DescriptionText').text
    # binding.pry
    @reservation_times = []
    doc.css('div.col-xs-12 div#restaurantAvailabilityResults div#ulSlots a span').each do |x|
      reservation_times << x.text
    end
    if @reservation_times.length == 0 
      @reservation_today = false
    else
      @reservations_today = true
    end
  end

  def get_next_reservation
    self.reservation_times[0]
  end

end

# binding.pry

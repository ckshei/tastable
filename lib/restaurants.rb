# require "tastable/version"
require 'pry'
require 'nokogiri'
require 'open-uri'
class Restaurant

  attr_accessor :name, :address, :phone, :link, :cuisine, :description, :reservation_times

  def initialize(name, address, phone, link, party_size)
    # binding.pry
    @name = name
    @address = address
    @phone = phone
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
  end

  def get_more_info
    puts "\nName: #{name}"
    puts "Cuisine: #{cuisine}"
    puts "Description: #{description}"
    puts "Next Available Reservation: #{self.reservation_times[0]}"
    puts "Address: #{address}"
    puts "Phone: #{phone}"
  end

  def more_reservation_times(party_size)
    puts "\nHere is a list of all available reservation times available today for a party of #{party_size}:"
    self.reservation_times.each {|x| puts "#{x}\n"}
  end


  def make_reservation
    puts "\nMake a reservation at #{self.name} here: #{link}"
  end

end

# binding.pry

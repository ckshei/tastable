class Restaurant

  attr_accessor :name, :address, :phone, :link, :cuisine, :description, :reservation_times

  def initialize(attributes, party_size)
    attributes.each do |key, value|
      self.send("#{key}=", value)
    end
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
  end

  def get_more_info
    puts "\nName: #{name}"
    puts "Cuisine: #{cuisine}"
    puts "#{description}"
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
    Launchy.open(link)
  end

end

# binding.pry

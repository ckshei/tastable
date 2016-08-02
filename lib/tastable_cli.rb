class Cli

  attr_accessor :user, :index

  def intro
    puts "Welcome to Tastable - a cli that helps you make same day reservations at nearby restaurants"

    sleep(1)
    self.run
  end

  def run
    puts "Where are you located? (enter your zipcode)"

    zip = gets.strip

    puts "\nHow many in your party? (Recommended: 1-6)"

    party_size = gets.strip

    @user = User.new(zip, party_size)

    if @user.restaurant_objects.count == 0
      puts "\nLooks like there are no restaurants with available reservations near you. Try inputting a different zip code or party size."
      
      sleep(2)
      self.run
    else
      self.print_restaurant_objects
    end
  end

  def print_restaurant_objects
    puts "\nHere are a list of nearby restaurants with reservations availabile today."
    puts "For more information, type in an index number (e.g. 1)"
    @user.restaurant_objects.each.with_index(1) do |res, i|
      puts "#{i}. #{res.name}"
    end
    self.more_info
  end

  def more_info
    @index = gets.to_i - 1
    if @index.between?(0,user.restaurant_objects.length-1)
      self.print_info
    else
      puts "\nInvalid entry - please try again:"
      puts "For more information, type in an index number (e.g. 1)"
      self.print_restaurant_objects
    end
  end

  def print_info
    @user.restaurant_objects[index].get_more_info
    puts "\nType res to make a reservation, back to go back, and more for more reservation times:"
    action
  end

  def action
      action = gets.strip
    if action == "res"
      self.res
    elsif action == "back"
      self.print_restaurant_objects
    elsif action == "more"
      self.more_reservations
    else
      puts "invalid entry - please try again"
      puts "Type res to make a reservation, back to go back, and more for more reservation times:"
      self.action(index)
    end
  end

  def res
    puts @user.restaurant_objects[@index].make_reservation
  end

  def more_reservations
    @user.restaurant_objects[index].more_reservation_times(user.party_size)
    self.second_action
  end

  def second_action
    puts "\nType res to make a reservation, and back to go back:"
    second_action = gets.strip
    if second_action == 'res'
      self.res
    elsif second_action == 'back'
      self.print_info
    else
      puts "\nInvalid entry - please try again"
      # binding.pry
      self.second_action
    end
  end
      

end


# binding.pry
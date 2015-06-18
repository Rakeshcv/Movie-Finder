require 'movie'

class MovieGuide

  @@options = ['list', 'add', 'find', 'quit']

  def self.options
    @@options
  end

  def initialize(filepath=nil)
    #check for empty filename

    if filepath.to_s.length == 0
      puts "File name is empty\nExiting..."
      exit!
    end

    Movie.set_filepath =filepath

    # locate the movie text file


    if Movie.file_usable?
      puts "File Found"
    elsif Movie.create_file # or create a new file
      puts "File Created"
    else
      puts "Exiting..\n" # exit if create fails
      exit!
    end
  end

  def fire!
    introduction

    #present options or menu

    result = nil

    #keep showing options until user hits quit
    until result == :quit
      result = respond_to_input(get_input)
    end

    conclusion
  end



  def get_input
    user_input = nil

    # Keep asking for user input until we get a valid action
    until MovieGuide.options.include?(user_input)
      puts "Options ==>  " << MovieGuide.options.join(", ")
      user_input = gets.chomp.downcase.strip
    end
    user_input
  end

  def respond_to_input(user_input)
    case user_input
    when 'list'
      puts "listing..."
    when 'find'
      puts "finding..."
    when 'add'
      add
      puts "Adding..."
    when 'quit'
      return :quit
    end
  end


  def introduction
    puts "\n\n<<< Welcome to the Movie Finder >>>\n\n"
    puts "This is an interactive guide to help you find the movie you love.\n\n"
  end


  def conclusion
    puts "\n<<< Program Terminated >>>\n\n\n"
  end

  def add

  end

end
require 'movie'

class MovieGuide

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

    conclusion
  end

  def introduction
    puts "\n\n<<< Welcome to the Movie Finder >>>\n\n"
    puts "This is an interactive guide to help you find the movie you love.\n\n"
  end


  def conclusion
    puts "\n<<< Program Terminated >>>\n\n\n"
  end

end
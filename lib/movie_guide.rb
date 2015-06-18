require 'movie'
require 'helper'

class MovieGuide

  @@options = ['list', 'add', 'find', 'delete', 'quit']

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
      user_input,args = get_input
      result = respond_to_input(user_input,args)
    end

    conclusion
  end



  def get_input
    user_input = nil

    # Keep asking for user input until we get a valid action
    until MovieGuide.options.include?(user_input)
      puts "Options ==>  " << MovieGuide.options.join(", ")
      print "--> "
      args = gets.chomp.downcase.strip.split(' ')
      user_input = args.shift
    end
    return  user_input,args
  end

  def respond_to_input(user_input,args=[])
    case user_input
    when 'list'
      list(args)
    when 'find'
      find(args.shift)
    when 'add'
      add
      when 'delete'
        delete
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
    output_header('Add a movie')

    puts "Leaving blank will result in error."
    puts "Rating should be between 1-10 for successfully adding a movie "

    movie = Movie.get_movie_info

    if movie.save_to_file
      puts "Movie Added"
    else
      puts "Error - Movie couldn't be added"
    end
  end

  def delete
    print 'Enter the movie name: '
    if Movie.delete_movie(gets.chomp.downcase)
        puts "Movie deleted"
    else
      puts "Movie not found"
    end


  end

  def list(args = [])
    sort_order = args.shift
    sort_order = args.shift if sort_order == 'by'
    sort_order = "name" unless ['name','genre','rating'].include?(sort_order)
    output_header('Listing movies')
    movies = Movie.saved_movies
    movies.sort! do |m1,m2|
      case sort_order
      when 'name' then m1.name <=> m2.name
      when 'genre' then m1.genre <=> m2.genre
      when 'rating' then m1.rating.to_i <=> m2.rating.to_i
      end
    end
    output_result(movies)

    puts "Sort the list : 'list by name | genre | rating' or list rating\n\n\n"
  end

  def find(keyword="")
    output_header('Find a movie')


    if keyword
      movies = Movie.saved_movies
      found = movies.select do |movie|
        movie.name.downcase.include?(keyword.downcase) ||
        movie.genre.downcase.include?(keyword.downcase) ||
        movie.rating.to_i == keyword.to_i
      end
      output_result(found)
    else
      puts "Find using a key phrase to search the movie list."
      puts "Examples: 'find spy', 'find action', 'find 4'\n\n"
    end
  end

  def output_header(text)
    puts "\n#{text.upcase.center(60)}\n\n"
  end

  def output_result(movies=[])
    print " " + "Name".ljust(30)
    print " " + "Genre".ljust(20)
    print " " + "Rating".rjust(6) + "\n"
    puts "-" * 60
    movies.each do |movie|
      line = " " << movie.name.titleize.ljust(30)
      line << " " + movie.genre.titleize.ljust(20)
      line << " " + movie.rating.rjust(6)
      puts line
    end
    puts "No listings found" if movies.empty?
    puts "-" * 60 << "\n\n\n"
  end


end
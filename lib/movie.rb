class Movie

  attr_accessor :rating, :name, :genre

  def initialize(args = {})
    @name = args[:name] || ''
    @genre = args[:genre] || ''
    @rating = args[:rating] || ''
  end

  def self.set_filepath=(filepath)
    @@file_name = filepath
  end

  def self.file_exists?
    # check for the file existence

    if @@file_name && File.exists?(@@file_name)
      return true
    else
      return false
    end

  end

  def self.file_usable?
    return false unless @@file_name
    return false unless File.exists?(@@file_name)
    return false unless File.readable?(@@file_name)
    return false unless File.writable?(@@file_name)
    return true
  end

  def self.create_file
    # create the movie file
    File.open(@@file_name, "w") unless file_exists?
    return file_usable?
  end


  def self.delete_movie(keyword ='')
    return false if keyword.length == 0
    return false unless Movie.file_usable?
    movie = ''
    movie_found = false

    movies = saved_movies


    movies.each do |m|
      movie << "#{[m.name, m.genre, m.rating].join("\t")}\n" unless m.name.downcase == keyword
      movie_found = true if m.name.downcase == keyword
    end

    File.open(@@file_name,'w') do |file|
      file.puts movie
    end

    movie_found
  end

  def self.get_movie_info
    args = {}

    print "Movie name: "
    args[:name] = gets.chomp.strip

    print "Genre: "
    args[:genre] = gets.chomp.strip

    print "Rating:[1-10] "
    args[:rating] = gets.chomp.strip

    return self.new(args)
  end

  def self.saved_movies
    movies = []

    if file_usable?
      file = File.open(@@file_name,'r')
      file.each_line do |line|
        movies << Movie.new.read_each_line(line.chomp) unless line.chomp.empty?
      end
      file.close
    end
    return movies
  end

  def read_each_line(line)
    line_array = line.split("\t")
    @name,@genre,@rating = line_array
    return self
  end

  def save_to_file
    return false unless @name.length > 0
    return false unless @genre.length > 0
    return false unless @rating.length > 0
    return false unless ( @rating.to_i.is_a?(Integer) && @rating.to_i.between?(1,10) )
    return false unless Movie.file_usable?
    File.open(@@file_name, 'a') do |file|
      file.puts "#{[@name, @genre, @rating].join("\t")}\n"
    end
    return true
  end



end
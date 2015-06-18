class Movie

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
end
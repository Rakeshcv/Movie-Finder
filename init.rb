=begin
<<<<<< Movie Finder >>>>>>>

 Launch this Ruby file from the command line
 to get started.

=end


APP_ROOT = File.dirname(__FILE__)

=begin
 require "#{APP_ROOT}/lib/guide"
 require File.join(APP_ROOT, 'lib', '')
 require File.join(APP_ROOT, 'lib', '')
=end


$:.unshift(File.join(APP_ROOT, 'lib'))
require 'movie_guide'

movie_guide = MovieGuide.new('movie.txt')
movie_guide.fire!

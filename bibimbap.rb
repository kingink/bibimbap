require 'rubygems'
require 'rmagick'
include Magick

unless ARGV[0]
  puts "\n\n\nYou need to specify a filename: bibimbap.rb <filename> [size]\nSize is optional and will defualt to 400\n\n\n"
  exit
end

img = Magick::Image.read(ARGV[0]).first
width = nil
height = nil

img.change_geometry('400x400') do |cols, rows, img|
  img.resize!(cols, rows)
  width = cols
  height = rows
end

file_name = "#{width}x#{height}_#{ARGV[0]}"

if File.exists?(file_name)
  puts "File already exists. Unable to write file."
  exit
end

img.write(file_name)

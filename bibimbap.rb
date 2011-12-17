require 'rubygems'
require 'rmagick'
include Magick

unless ARGV[0]
  puts "\n\n\nYou need to specify a filename: bibimbap.rb <filename> [size,size,size]\nSizes are optional comma separated list\n if no sizes are specified, one image will be generated of 400 size\n\n\n"
  exit
end

img = Magick::Image.read(ARGV[0]).first
width = nil
height = nil

unless ARGV[1].nil?
  sizes = ARGV[1].split(',') 
else
  sizes = '400'
end

sizes.each do |size| 
  img.change_geometry("#{size}x#{size}") do |cols, rows, img|
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
end

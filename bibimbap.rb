require 'rubygems'
require 'rmagick'
include Magick

class Bibimbap
  def boom
    unless ARGV[0]
      puts "\n\n\nYou need to specify a filename: bibimbap.rb <filename> [size,size,size] [effect]\nSizes are optional comma separated list. If no sizes are specified, one image will be generated of 400 size\nEffect is optional, available effects: vignette, negate, spread, oil_paint, emboss.\n\n\n"
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

      img = apply_vignette(img) if ARGV[2] == 'vignette'
      img = apply_negate(img) if ARGV[2] == 'negate'
      img = apply_spread(img) if ARGV[2] == 'spread'
      img = apply_oil_paint(img) if ARGV[2] == 'oil_paint'
      img = apply_emboss(img) if ARGV[2] == 'emboss'

      file_name = "#{width}x#{height}_#{ARGV[0]}"

      if File.exists?(file_name)
        puts "File already exists. Unable to write file."
        exit
      end

      img.write(file_name)
    end
  end

  def apply_vignette(img)
    img = img.vignette
  end

  def apply_negate(img)
    img = img.negate
  end

  def apply_spread(img)
    img = img.spread
  end

  def apply_oil_paint(img)
    img = img.oil_paint
  end

  def apply_emboss(img)
    img = img.emboss
  end

end

b = Bibimbap.new
b.boom

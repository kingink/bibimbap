require 'rubygems'
require 'rmagick'
require 'optparse'

include Magick

class Bibimbap
  def boom
    options = {}
    option_parser = OptionParser.new do |opts|
      opts.banner = "Usage: bibimbap.rb [options] file1"
      opts.on("-s [SIZE]", "--size [SIZE]", 'Some description here') do |size|
        options[:size] = size
      end
      options[:size] = '400' if options[:size].nil?
      opts.on("-e [EFFECT]", "--effect [EFFECT]", 'Effect name [vignette|emboss|negate|oil_paint|spread]') do |effect|
        options[:effect] = effect
      end
      opts.on( '-h', '--help', 'Display this screen' ) do
        help(opts)
      end
      help(opts) if ARGV.empty?
    end
    
    option_parser.parse!
    puts options.inspect
    
    img = Magick::Image.read(ARGV[0]).first
    width = nil
    height = nil

    img.change_geometry("#{options[:size]}x#{options[:size]}") do |cols, rows, img|
      img.resize!(cols, rows)
      width = cols
      height = rows
    end

    img = apply_effect(options[:effect], img) if options[:effect]

    file_name = "#{width}x#{height}_#{ARGV[0]}"

    if File.exists?(file_name)
      puts "File already exists. Unable to write file."
      exit
    end

    img.write(file_name)
  end

  def apply_effect(effect, img)
    img = img.send(effect)
  end

  def help(opts) 
    puts opts
    exit
  end
end

b = Bibimbap.new
b.boom

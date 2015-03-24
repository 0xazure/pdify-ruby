require "pry"

require "optparse"
require "prawn"

require "pdify/version"
require "pdify/configuration"
require "pdify/converter"

module Pdify
  class Pdify
    def main
      options = Configuration.parse_options!(ARGV)

      Converter.new(options[:source], options[:destination]).convert!

      puts "Wrote #{options[:source].path} to #{options[:destination]}.pdf"
    end
  end
end

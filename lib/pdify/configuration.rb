module Pdify
  class Configuration
    def self.parse_options!(argv)
      options = {}

      parser = OptionParser.new do |opts|
        opts.banner = "Usage: pdify SOURCE [-d DESTINATION]"

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        opts.on_tail("-v", "--version", "Show version") do
          puts VERSION
          exit
        end

        options[:destination] = ""
        opts.on("-d", "--destination DESTINATION", "Specify name of destination file") do |dest|
          options[:destination] = raw_basename dest
        end
      end

      begin
        parser.parse!(argv)
      rescue OptionParser::InvalidOption => e
        $stderr.puts e
        $stderr.puts parser
        exit 1
      end

      begin
        options[:source] = File.new(argv[0].to_s)
        if options[:destination].empty?
          options[:destination] = raw_basename options[:source]
        end
      rescue Errno::ENOENT => e
        $stderr.puts e
        exit 1
      end

      options
    end

    private
    def self.raw_basename(file)
      File.basename file, ".*"
    end
  end
end

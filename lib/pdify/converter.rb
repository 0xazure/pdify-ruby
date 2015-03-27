require "fastimage"

module Pdify
  class Converter
    attr_accessor :src, :dest

    def initialize(source, destination)
      self.src = source
      self.dest = destination
    end

    def convert!
      match_path = File.join src, "**", "*.{png,jpg,jpeg}"
      files = Dir.glob match_path
      files.sort_by! { |f| f.sub(/\[.*?\]/, '') }
      make_pdf files
    end

    private
    def make_pdf(files)
      pdf = Prawn::Document.new(skip_page_creation: true)
      margin = 0

      files.each do |file|
        width, height = dimensions file
        image_options = {
          position: :center,
          vposition: :center,
          fit: [width, height]
        }
        pdf.start_new_page margin: margin, size: [width, height]
        pdf.image "#{file}", image_options
      end

      pdf.render_file "#{dest}.pdf"
    end

    def dimensions(img)
      width, height = FastImage.size img
      [width, height]
    end
  end
end

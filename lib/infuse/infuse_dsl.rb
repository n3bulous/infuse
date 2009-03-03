require 'singleton'

class InfuseDSL
  include Singleton

  attr_accessor :slides, :title, :author, :company, :copyright, :subtitle, :background
  attr_accessor :source_file, :output_dir

  def initialize
    @slides = []

    @header_template =  File.dirname(__FILE__) + "/themes/plain/header.html.erb"
    @footer_template =  File.dirname(__FILE__) + "/themes/plain/footer.html.erb"
    @slide_template =   File.dirname(__FILE__) + "/themes/plain/slide.html.erb"
  end

  def add_slide(slide)
    @slides << slide
  end

  def run
    header_tpl = IO.read(@header_template)
    footer_tpl = IO.read(@footer_template)
    slide_tpl = IO.read(@slide_template)

    header_with_data = ERB.new(header_tpl, 0, ">").result(self.send(:binding))
    footer_with_data = ERB.new(footer_tpl, 0, ">").result(self.send(:binding))

    slides_with_data = ""
    @slides.each do |s|
      slides_with_data << s.convert(slide_tpl)
    end

    output = header_with_data + "\n" + slides_with_data + "\n" + footer_with_data

    prepare_target_dir

    begin
      File.new(output_file, "w").puts(output)
    rescue
      puts ""
    end

  end

private
  def output_file
    @output_dir + "/" + File.basename(@source_file, ".#{INFUSE_EXTENSION}") + ".html"
  end

  def prepare_target_dir
    begin
      FileUtils.mkdir(@output_dir)
      copy_default_files
    rescue Errno::EEXIST
      puts "-- #{output_dir} already exists -- canceling initialization. "
      return
    end
  end

  def copy_default_files
    FileUtils.cp_r(File.dirname(__FILE__) + "/../s6/shared/", @output_dir)
    FileUtils.cp_r(File.dirname(__FILE__) + "/themes/plain/css/custom.css", @output_dir)
  end

end

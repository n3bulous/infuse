require 'fileutils'
require 'singleton'

class InfuseDSL
  include Singleton

  attr_accessor :slides, :title, :author, :company, :copyright, :subtitle
  attr_accessor :background, :format, :transition
  # Derived
  attr_accessor :source_file, :output_dir

  def initialize
    @slides = []
    @title = @author = @company = @copyright = @subtitle = @background = @format = @transition = ""

    @template_dir = File.dirname(__FILE__) + "/themes/plain/"
    @operashow_templates = {
        :header => "operashow-header.html.erb",
        :footer => "operashow-footer.html.erb",
        :slide => "slide.html.erb",
        :title_slide => "title-page.html.erb"
    }

    @html_templates = {
        :header => "header.html.erb",
        :footer => "footer.html.erb",
        :slide => "slide.html.erb",
        :title_slide => "title-page.html.erb"
    }
  end

  def add_slide(slide)
    @slides << slide
  end

  def run
    html_output = generate_slideshow(@html_templates)
    operashow_output = generate_slideshow(@operashow_templates)

    prepare_target_dir

    begin
      File.new(output_file, "w").puts(html_output)
      File.new(output_file('operashow-'), "w").puts(operashow_output)
    rescue
      puts $!
      exit
    end

  end

private

  def generate_slide_output(header_tpl, footer_tpl, slide_tpl, title_tpl)
    header_with_data = ERB.new(header_tpl, 0, ">").result(self.send(:binding))
    footer_with_data = ERB.new(footer_tpl, 0, ">").result(self.send(:binding))

    title_slide_with_data = ERB.new(title_tpl, 0, ">").result(self.send(:binding))

    slides_with_data = ""
    @slides.each do |s|
      slides_with_data << s.convert(slide_tpl) + "\n\n"
    end

    output = header_with_data + "\n" + title_slide_with_data + "\n" + slides_with_data + "\n" + footer_with_data
  end

  def generate_slideshow(templates)
    header_tpl = IO.read(@template_dir + templates[:header])
    footer_tpl = IO.read(@template_dir + templates[:footer])
    slide_tpl = IO.read(@template_dir + templates[:slide])
    title_tpl = IO.read(@template_dir + templates[:title_slide])

    generate_slide_output(header_tpl, footer_tpl, slide_tpl, title_tpl)
  end

  def output_file(name_prefix="")
    @output_dir + "/" + name_prefix + File.basename(@source_file, ".#{INFUSE_EXTENSION}") + ".html"
  end

  # TODO: Update files based on differences, at least missing files.
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
    FileUtils.cp_r(File.dirname(__FILE__) + "/../s6/shared", @output_dir)
    FileUtils.cp_r(File.dirname(__FILE__) + "/themes/plain/custom.css", @output_dir)
    FileUtils.cp_r(File.dirname(__FILE__) + "/themes/plain/operashow.css", @output_dir + "/shared")
    FileUtils.cp_r(File.dirname(__FILE__) + "/themes/plain/operashow-custom.css", @output_dir)
  end

end

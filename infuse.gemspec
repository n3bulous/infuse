# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{infuse}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kevin McFadden"]
  s.date = %q{2009-03-03}
  s.default_executable = %q{infuse}
  s.email = %q{kevin+github@conceptsahead.com}
  s.executables = ["infuse"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc", "Rakefile", "lib/infuse", "lib/infuse/infuse_dsl.rb", "lib/infuse/slide.rb", "lib/infuse/themes", "lib/infuse/themes/plain", "lib/infuse/themes/plain/css", "lib/infuse/themes/plain/css/custom.css", "lib/infuse/themes/plain/footer.html.erb", "lib/infuse/themes/plain/header.html.erb", "lib/infuse/themes/plain/js", "lib/infuse/themes/plain/slide.html.erb", "lib/infuse/themes/plain/title-page.html.erb", "lib/infuse/version.rb", "lib/infuse.rb", "lib/s6", "lib/s6/blank.css", "lib/s6/blank.html", "lib/s6/blank.svg", "lib/s6/README.textile", "lib/s6/shared", "lib/s6/shared/jquery.js", "lib/s6/shared/outline.css", "lib/s6/shared/print.css", "lib/s6/shared/slides.core.js", "lib/s6/shared/slides.css", "lib/s6/shared/slides.js", "test/test_helper.rb", "test/unit", "test/unit/infuse_test.rb", "bin/infuse"]
  s.has_rdoc = true
  s.homepage = %q{http://conceptsahead.com}
  s.rdoc_options = ["--main", "README.textile"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<redcloth>, [">= 4.0.0"])
    else
      s.add_dependency(%q<redcloth>, [">= 4.0.0"])
    end
  else
    s.add_dependency(%q<redcloth>, [">= 4.0.0"])
  end
end

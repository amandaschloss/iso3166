# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "iso3166/version"

Gem::Specification.new do |s|
  s.name        = "iso3166"
  s.version     = ISO3166::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Vladimir Andrijevik"]
  s.email       = ["vladimir@andrijevik.net"]
  s.homepage    = "https://github.com/vandrijevik/iso3166"
  s.summary     = "A Ruby library containing the short country names and alpha-2 codes from ISO 3166-1"
  s.description = <<-END_OF_DESCRIPTION.gsub(/^ .*/,"")
    ISO 3166-1 provides a database of information on country names
    and short codes. While the full database is not free, the
    Maintenance Agency for ISO 3166 country codes provides a list of
    the names and 2-character codes for the countries included in the
    standard.
    
    Per their website, "The short country names from ISO 3166-1 and the 
    alpha-2 codes are made available by ISO at no charge for 
    internal use and non-commercial purposes" so please use accordingly.
  END_OF_DESCRIPTION

  s.rubyforge_project = "iso3166"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rr"
  s.add_development_dependency "rspec"
end

# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "kimaya/version"

Gem::Specification.new do |s|
  s.name        = "kimaya"
  s.version     = Kimaya::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Shailesh Patil"]
  s.email       = ["shailesh@joshsoftware.com"]
  s.homepage    = ""
  s.summary     = %q{Core calculations for TPN}
  s.description = %q{Core calculations for TPN}

  s.rubyforge_project = "kimaya"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "activesupport"
  s.add_dependency "activemodel"
  s.add_dependency "i18n"
  s.add_development_dependency "rspec"
end

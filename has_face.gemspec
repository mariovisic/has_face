# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "has_face/version"

Gem::Specification.new do |s|
  s.name        = "has_face"
  s.version     = HasFace::VERSION
  s.authors     = ["Mario Visic"]
  s.email       = ["mario@mariovisic.com"]
  s.homepage    = "https://github.com/mariovisic/has_face"
  s.summary     = "Easily validate if an image contains faces"
  s.description = "An Active Model validator that uses the face.com API to ensures an image contains a face"

  s.rubyforge_project = "has_face"

  s.add_dependency 'rails', '>= 3.0'
  s.add_dependency 'rest-client'

  s.add_development_dependency 'rspec',    '>= 2.0'
  s.add_development_dependency 'rr',       '>= 1.0'
  s.add_development_dependency 'vcr',      '>= 1.0'
  s.add_development_dependency 'fakeweb',  '>= 1.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

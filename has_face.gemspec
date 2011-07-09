# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "has_face/version"

Gem::Specification.new do |s|
  s.name        = "has_face"
  s.version     = HasFace::VERSION
  s.authors     = ["Mario Visic"]
  s.email       = ["mario@mariovisic.com"]
  s.homepage    = ""
  s.summary     = "An Active Model validator that uses the face.com API to ensures an image contains a face"
  s.description = "An Active Model validator that uses the face.com API to ensures an image contains a face"

  s.rubyforge_project = "has_face"

  s.add_dependency 'activemodel', '>= 3.0'

  s.add_development_dependency 'rspec',        '>= 2.0'
  s.add_development_dependency 'rr',           '>= 1.0'
  s.add_development_dependency 'activerecord', '>= 3.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

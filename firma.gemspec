Gem::Specification.new do |s|
  s.name              = "firma"
  s.version           = "0.0.1"
  s.summary           = "Sign PDF documents the easy way"
  s.description       = "Sign PDF documents"
  s.authors           = ["elcuervo"]
  s.email             = ["yo@brunoaguirre.com"]
  s.homepage          = "http://github.com/elcuervo/subskribas"
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files test`.split("\n")

  s.add_dependency("origami", "~> 1.2.4")

  s.add_development_dependency("minitest", "~> 3.5.0")
end

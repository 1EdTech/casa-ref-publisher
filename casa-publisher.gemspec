Gem::Specification.new do |s|

  s.name        = 'casa-publisher'
  s.version     = '0.0.01'
  s.summary     = 'Reference implementation of the CASA Protocol Publisher Module'
  s.authors     = ['Eric Bollens']
  s.email       = ['ebollens@ucla.edu']
  s.homepage    = 'https://appsharing.github.io'
  s.license     = 'BSD-3-Clause'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_dependency 'sinatra'
  s.add_dependency 'sinatra-contrib'
  s.add_dependency 'casa-payload'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'coveralls'

end
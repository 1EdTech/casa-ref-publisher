Gem::Specification.new do |s|

  s.name        = 'casa-publisher'
  s.version     = '0.0.01'
  s.summary     = 'Reference implementation of the CASA Protocol Publisher Module'
  s.authors     = ['Eric Bollens']
  s.email       = ['ebollens@ucla.edu']
  s.homepage    = 'https://appsharing.github.io/casa-protocol'
  s.license     = 'BSD-3-Clause'

  s.files       = ['lib/casa-publisher.rb']

  s.add_dependency 'sinatra'
  s.add_dependency 'casa-payload'

  s.add_development_dependency 'rake'

end
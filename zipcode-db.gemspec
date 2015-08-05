Gem::Specification.new do |s|
  s.name        = 'zipcode-db'
  s.version     = '1.0.0'
  s.licenses    = ['MIT']
  s.summary     = 'Unified zip/postal codes and cities queries'
  s.description = <<-EOS
   Uniformly query city information by zip/postal code and city name.
  EOS
  s.authors     = ['Loic Nageleisen']
  s.email       = 'loic.nageleisen@gmail.com'
  s.files       = Dir['lib/**/*.rb']
  s.homepage    = 'https://github.com/lloeki/zipcode-db'

  s.add_development_dependency 'pry'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest'
end

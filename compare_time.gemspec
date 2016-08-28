Gem::Specification.new do |s|
  s.name        = 'compare_time'
  s.version     = '0.0.4'
  s.date        = '2016-08-28'
  s.summary     = "Compare execution times for given blocks"
  s.description = "Compare execution times for given blocks, right?"
  s.authors     = ["Bartek Gladecki"]
  s.email       = 'bgladecki@gmail.com'
  s.files       = ["lib/compare_time.rb"]
  s.homepage    = 'http://rubygems.org/gems/compare_time'
  s.license     = 'MIT'

  s.add_runtime_dependency 'colorize', '~> 0.8.1'
end

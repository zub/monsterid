Gem::Specification.new do |s|
  s.name = "monsterid"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Knut Aldrin"]
  s.date = "2016-10-16"
  s.description = "Port/rework of the php script, with new monsters snatched from the WP plugin"
  s.email = "knutaldrin@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    "LICENSE",
    "README.md",
    "VERSION",
    "CHANGELOG",
    "lib/monsterid.rb",
    "lib/parts/*.png"
  ]  

  s.homepage = "http://github.com/knutaldrin/monsterid"
  s.licenses = ["CC BY 4.0"]
  s.summary = "Generates tiny little monsters to discern users."
  
  s.add_runtime_dependency 'oily_png', '~> 1.2', '>= 1.2.1'
  
  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'rubocop', '~> 0.44.1'
end


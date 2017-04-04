Gem::Specification.new do |s|
  s.name = "monsterid"
  s.version = File.read("VERSION").strip
  s.require_paths = ["lib"]
  s.authors = ["Knut Aldrin"]
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
  ] + Dir.glob("lib/parts/*.png")

  s.homepage = "https://github.com/knutaldrin/monsterid"
  s.licenses = ["CC-BY-4.0"]
  s.summary = "Generates tiny little monsters to discern users."
  
  s.add_runtime_dependency 'chunky_png', '~> 1.3', '>= 1.3.7'
  
  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'rubocop', '~> 0.44.1'
end


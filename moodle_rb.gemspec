lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'moodle_rb/version'

Gem::Specification.new do |spec|
  spec.name          = 'moodle_rb'
  spec.version       = MoodleRb::VERSION
  spec.authors       = ['Sam Giffney']
  spec.email         = ['samg@jobready.com.au']
  spec.summary       = %q{ A Ruby client for the Moodle API }
  spec.homepage      = 'https://github.com/jobready/moodle-rb'
  spec.license       = 'MIT'

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE Rakefile)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = Dir['spec/**/*']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2'
  spec.add_development_dependency 'rake', '~> 0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 1.24.6'
  spec.add_development_dependency 'vcr', '~> 2.9'

  spec.add_dependency 'httparty', '>= 0.11.0'
end

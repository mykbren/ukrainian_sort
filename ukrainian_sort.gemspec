# frozen_string_literal: true

require_relative 'lib/ukrainian_sort/version'

Gem::Specification.new do |spec|
  spec.name          = 'ukrainian_sort'
  spec.version       = UkrainianSort::VERSION
  spec.authors       = ['mykbren']
  spec.email         = ['myk.bren@gmail.com']

  spec.summary       = 'Provides sorting functionality for Ukrainian language strings.'
  spec.description = <<~DESC.strip
    A Ruby gem that implements sorting algorithms specifically designed for Ukrainian language strings,
    ensuring proper handling of unique characters and collation rules.
  DESC
  spec.homepage      = 'https://github.com/mykbren/ukrainian_sort'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.1.0'
  spec.metadata['homepage_uri']     = spec.homepage
  spec.metadata['source_code_uri']  = spec.homepage
  spec.metadata['changelog_uri']    = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Includes all files tracked by git
  spec.files = Dir.glob('lib/**/*') + Dir.glob('bin/*') + ['README.md', 'CHANGELOG.md', 'LICENSE.txt',
                                                           'ukrainian_sort.gemspec']

  spec.bindir        = 'bin'
  spec.executables   = %w[console setup]
  spec.require_paths = ['lib']
end

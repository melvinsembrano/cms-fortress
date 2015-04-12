# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name      = "cms-fortress"
  s.version   = "1.3.9"

  s.authors           = ["Melvin Sembrano"]
  s.date              = "2015-04-12"
  s.description       = "Comfortable Mexican Sofa (CMS) - User and role management extension"
  s.email             = "melvinsembrano@gmail.com"
  s.extra_rdoc_files  = [ "LICENSE.txt", "README.rdoc" ]

  s.homepage          = "http://github.com/melvinsembrano/cms-fortress"
  s.licenses          = "MIT"
  s.summary           = "Comfortable Mexican Sofa (CMS) - User and role management extension"

  s.files             = `git ls-files`.split($/)
  s.executables       = []
  s.test_files        = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths     = ["lib"]

  s.add_dependency 'rails', '~> 4.0', '>= 4.0.0'
  s.add_dependency 'comfortable_mexican_sofa', '~> 1.12', '>= 1.12.5'
  s.add_dependency 'devise',                    '~> 3.2'
  s.add_dependency 'cancancan',                 '~> 1.9'
  s.add_dependency 'delayed_job',               '~> 4'
  s.add_dependency 'tinymce-rails', '~> 4.1', '>= 4.1.0'
  s.add_dependency 'tinymce-rails-langs',       '~> 4.0'
  s.add_dependency 'aasm',                      '~> 4.0'

  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'minitest', '~> 4.7', '>= 4.7.3'
  s.add_development_dependency 'minitest-rails'
  s.add_development_dependency 'minitest-spec-rails'
  s.add_development_dependency 'minitest-reporters'
  s.add_development_dependency 'sqlite3'
end

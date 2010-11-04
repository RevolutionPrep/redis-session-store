# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{redis-session-store}
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["ryanmoran"]
  s.date = %q{2010-11-03}
  s.description = %q{Port of the Memcache session store, forked from mattmatt's original gem}
  s.email = %q{ryan.moran@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.md"
  ]
  s.files = [
    ".gitignore",
     "LICENSE",
     "README.md",
     "Rakefile",
     "VERSION",
     "lib/redis-session-store.rb",
     "redis-session-store.gemspec"
  ]
  s.homepage = %q{http://github.com/ryanmoran/redis-session-store}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Redis-backed Rails session store}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<redis>, [">= 2.0.13"])
    else
      s.add_dependency(%q<redis>, [">= 2.0.13"])
    end
  else
    s.add_dependency(%q<redis>, [">= 2.0.13"])
  end
end


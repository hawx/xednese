# -*- encoding: utf-8 -*-
require File.expand_path("../lib/xednese/version", __FILE__)

Gem::Specification.new do |s|
  s.name         = "xednese"
  s.author       = "Joshua Hawxwell"
  s.email        = "m@hawx.me"
  s.summary      = "Client library for interacting with the Esendex API"
  s.homepage     = "http://github.com/hawx/xednese"
  s.version      = Esendex::VERSION
  s.license      = 'MIT'

  s.description  = <<-DESC
    Xednese provides an easy to use client for interacting with the Esendex
    REST API.
  DESC

  s.add_dependency 'seq', '~> 0.2.0'
  s.add_dependency 'serialisable', '~> 0.0.0'
  s.add_dependency 'nokogiri', '~> 1.6'

  s.add_development_dependency 'rake', '~> 10.1'
  s.add_development_dependency 'minitest', '~> 5.2'
  s.add_development_dependency 'mocha', '~> 1.0'

  s.files        = %w(README.md Rakefile LICENCE)
  s.files       += Dir["{lib,spec}/**/*"] & `git ls-files`.split("\n")
  s.test_files   = Dir["spec/**/*"] & `git ls-files`.split("\n")
end

#!/usr/bin/ruby
require 'rubygems'
require 'yaml'

@config = YAML::load(File.open('../config.yml'))

puts @config['stylesheets']['path']

puts '-----'

@config['stylesheets']['css'].each { |key|
  export_file = key['filename']
  puts 'create file: ' + export_file
  key['files'].each { |file|
    puts '          => ' + file
  }
}
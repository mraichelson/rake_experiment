##
# Some project level configuration is stored in CONFIG.YML
##
require 'rubygems'
require 'yaml'
require 'w3c_validators'
include W3CValidators

config = YAML::load(File.open('config.yml'))

# project build tasks
namespace :build do
  desc "Merge and compress CSS files"
  task :css do
    puts " => Merging and Compressing CSS files."
    config['stylesheets']['css'].each { |key|
      export_file = key['filename']
      puts 'Create file: ' + export_file
      key['files'].each { |file|
        puts ' => ' + file
      }
    }
  end
  
  desc "Build HTML files from Source"
  task :html do
    puts " => Building HTML files."
  end
  
  desc "Merge and compress JS files"
  task :js do
    puts " => Merging and Compressing JS files."
  end

  desc "Perform all Front-End build tasks"
  task :all => [:css, :js, :html] do
    puts " => Performed all Build tasks."
  end
end

# automated testing is something we should be considering
namespace :test do
  desc "Test CSS files with W3c validator"
  task :css do
    puts " => Testing CSS files with W3c validator."
    puts "--v--"
    config['stylesheets']['css'].each { |key|
      export_file = key['filename']
      puts 'Testing components of: ' + export_file
      key['files'].each { |file|
        puts ' => Validating ' + file
        validator = CSSValidator.new
        filepath = config['stylesheets']['path']
        # puts @filepath + file
        css_file = File.open(filepath + file)
        results = validator.validate_file(css_file)
        if results.errors.length > 0
          puts '    x-> ERRORS FOUND! :('
          results.errors.each do |err|
            puts err.to_s
          end
        else
          puts '    +-> File is Valid! :)'
        end
      }
    }
    puts "--^--"
  end

  desc "Test HTML files with W3c validator."
  task :html do
    puts " => Testing HTML files with W3c validator."
    puts "--v--"
    # for 
    puts "--^--"
  end

  desc "Test JS files with JSLint"
  task :js do
    puts " => Testing JS files with JSLint."
    puts "-- JS Validation Results --"
    sh   "juicer verify ./_source/js/project.js"
    puts "-- JS Validation Results --"
  end

  desc "Perform all Test tasks"
  task :all => [:css, :html, :js] do 
    puts " => Performed all Test tasks."
  end
end

# version control tasks for Subversion
namespace :svn do
  desc "Create a new tagged release in Subversion"
  task :tag do
    puts " => Creating new SVN Tag for this release."
  end
end

# version control tasks for Git
namespace :git do
  desc "Create a new tagged release in Git"
  task :tag do
    puts " => Creating a new Git Tag for this release."
  end
end


namespace :setup do
  desc "Use Builder to install necessary Gems."
  task :install do
    puts " => Installing dependency Gems"
    sh   "bundle install"
    sh   "juicer install yui_compressor"
    sh   "juicer install jslint"
    puts " => Done installing dependencies"
  end  
end

task :default => "build:all"

###
# Ruby Helpers
##
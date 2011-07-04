##
# Some project level configuration is stored in CONFIG.YML
##
require 'rubygems'
require 'nokogiri'
require 'w3c_validators'
require 'yaml'
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
  end # end BUILD:CSS
  
  desc "Build HTML files from Source"
  task :html do
    puts " => Building HTML files."
  end # end BUILD:HTML
  
  desc "Merge and compress JS files"
  task :js do
    puts " => Merging and Compressing JS files."
  end # end BUILD:JS

  desc "Perform all Front-End build tasks"
  task :all => [:css, :js, :html] do
    puts " => Performed all Build tasks."
  end # end BUILD:ALL
end # end of BUILD tasks

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
  end # end TEST:CSS

  desc "Test HTML files with W3c validator."
  task :html do
    puts " => Testing HTML files with W3c validator."
    puts "--v--"
    # for 
    puts "--^--"
  end # end TEST:HTML

  desc "Test JS files with JSLint"
  task :js do
    puts " => Testing JS files with JSLint."
    puts "--v--"
    config['scripts']['js'].each { |key|
      export_file = key['filename']
      puts 'Testing components of: ' + export_file
      key['files'].each { |file|
        puts ' => Validating ' + file
        filepath = config['scripts']['path']
        js_file = filepath + file
        # bouncing this out to the shell isn't an efficient way of doing this...
        # sh "juicer verify " + js_file
        js = File.read(js_file)
        puts js
        
      }
    }
    puts "--^--"
  end # end TEST:JS

  desc "Perform all Test tasks"
  task :all => [:css, :html, :js] do 
    puts " => Performed all Test tasks."
  end # end TEST:ALL
end # end of TEST tasks

# image management tasks
namespace :img do
  desc "Compress image files with ImageOptim"
  task :compress do
    puts " => Launching ImageOptim to compress image files."
    sh   "open -a ImageOptim.app "
  end # end IMG:COMPRESS
end # end of IMG tasks

# version control tasks for Subversion
namespace :svn do
  desc "Create a new tagged release in Subversion"
  task :tag do
    puts " => Creating new SVN Tag for this release."
  end # end SVN:TAG
end # end of SVN tasks

# version control tasks for Git
namespace :git do
  desc "Create a new tagged release in Git"
  task :tag do
    puts " => Creating a new Git Tag for this release."
  end # end GIT:TAG
end #end of GIT tasks


namespace :setup do
  desc "Use Builder to install necessary Gems."
  task :install do
    puts " => Installing dependency Gems"
    sh   "bundle install"
    sh   "juicer install yui_compressor"
    sh   "juicer install jslint"
    puts " => Done installing dependencies"
  end # end SETUP:INSTALL
end # end of SETUP tasks

task :default => "build:all"
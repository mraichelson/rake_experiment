##
# Some project level configuration is stored in CONFIG.YML
# Version History
# => 0.1 Internal testing version (2011-07-07)
##
require 'rubygems'
# require 'nokogiri'
require 'hpricot'
require 'w3c_validators'
require 'yaml'
require 'colorize'
include W3CValidators

$config = YAML::load(File.open('config.yml'))

# project build tasks
namespace :build do
  desc 'Merge and compress CSS files'
  task :css do
    puts ''
    puts ' => Merging and Compressing CSS files.'.blue.on_white
    puts ''
    $config['stylesheets']['manage'].each { |file|
      source_path = $config['stylesheets']['source']
      build_path  = $config['stylesheets']['export']
      puts "    +-> ".green + "Building " + "#{source_path}#{file}".yellow + " to " + "#{build_path}#{file}".green
      `juicer merge #{source_path}#{file} -o #{build_path}#{file} --force`
    }
    puts ''
  end # end BUILD:CSS
  
  desc 'Build HTML files from Source'
  task :html do
    puts ''
    puts ' => Building HTML files.'.blue.on_white
    puts ''
    file_path = $config['html']['source']
    Dir[file_path + '*.html'].each { |file|
      input_file = file
      output_file = file.sub($config['html']['source'], $config['html']['export'])
      puts "    +-> ".green + "Building " + "#{input_file}".yellow + " to " + "#{output_file}".green
      f = File.open(input_file)
      @doc = Hpricot(f)
      @doc.search('link.managed').remove
      @doc.search('script.managed').remove
      File.open output_file, 'w' do |outfile|
        outfile.write @doc.to_original_html.gsub(/^\s*$\n/,'')
      end
    }
    puts ''
  end # end BUILD:HTML
  
  desc 'Merge and compress JS files'
  task :js do
    puts ''
    puts ' => Merging and Compressing JS files.'.blue.on_white
    puts ''
    $config['scripts']['manage'].each { |file|
      source_path = $config['scripts']['source']
      build_path  = $config['scripts']['export']
      puts "    +-> ".green + "Building " + "#{source_path}#{file}".yellow + " to " + "#{build_path}#{file}".green
      # -s flag skips JSLint verification before merging...
      `juicer merge -s #{source_path}#{file} -o #{build_path}#{file} --force`
    }
    puts ''
  end # end BUILD:JS

  desc 'Perform all Front-End build tasks'
  task :all => [:css, :html, :js] do
    puts ''
    puts ' => Performed all Build tasks.'.blue.on_green
    puts '    (You did TEST first, right?)'.yellow
    puts '    (Should you be running IMG:SYNC too?)'.yellow
    puts ''
  end # end BUILD:ALL
end # end of BUILD tasks

# automated testing is something we should be considering
namespace :test do
  desc 'Test CSS files with W3c validator'
  task :css do
    puts ''
    puts ' => Testing CSS files with W3c validator.'.blue.on_white
    puts ''
    $config['stylesheets']['validate'].each { |file_to_test|
      file_path = $config['stylesheets']['source']
      puts '    => Validating ' + file_to_test
      validator = CSSValidator.new
      css_file = File.open(file_path + file_to_test)
      results = validator.validate_file(css_file)
      if results.errors.length > 0
        puts '       x-> Errors found!'.red
        results.errors.each { |err|
          error_text = err.message.to_s
          error_text = error_text.strip.tr('  ',' ')
          puts '           !'.red + ' Error on line ' + " #{err.line} ".yellow.on_red
          puts '             ' + "#{error_text}"
        }
      else
        puts '       +-> File validated successfully. :)'.green
      end
    }
    puts ''
  end # end TEST:CSS

  desc "Test HTML files with W3c validator."
  task :html do
    puts ''
    puts ' => Testing HTML files with W3c validator.'.blue.on_white
    puts ''
    file_path = $config['html']['source']
    Dir[file_path + '*.html'].each { |file_to_test| 
      puts '    => Validating ' + file_to_test
      validator = MarkupValidator.new
      # validator.set_debug!(true)
      results = validator.validate_file(file_to_test)
      if results.errors.length > 0
        puts "       x-> Errors found in #{file_to_test}".red
        # results.errors.each { |err|
        #   puts err.to_s
        # }
      else
        puts '       +-> File validated successfully. :)'.green
      end
    }
    puts ''
  end # end TEST:HTML

  desc 'Test JS files with JSLint'
  task :js do
    puts ''
    puts ' => Testing JS files with JSLint.'.blue.on_white
    puts ''
    $config['scripts']['jslint'].each { |file_to_test|
      file_to_test = $config['scripts']['source'] + file_to_test
      puts '    => Testing ' + file_to_test + ' with JSLint'
      # It seems really sideways to me to bounce this back out to another shell command
      # but I can't find any docs around using Juicer from within other ruby scripts...
      sh   'juicer verify ' + file_to_test
    }
    puts ''
  end # end TEST:JS

  desc 'Perform all Test tasks'
  task :all => [:css, :html, :js] do 
    puts ''
    puts ' => Performed all Test tasks.'.blue.on_green
    puts ''
  end # end TEST:ALL
end # end of TEST tasks

# image management tasks
namespace :img do
  desc 'Compress image files with ImageOptim'
  task :compress do
    puts ''
    puts ' => Launching ImageOptim to compress image files.'.blue.on_white
    puts ''
    cmd = 'open -a ImageOptim.app ' + $config['images']['source']
    `#{cmd}`
  end # end IMG:COMPRESS
  
  desc "Sync image directory from DEV to BUILD"
  task :sync do
    puts ''
    puts ' => Syncing DEV images to BUILD images'.blue.on_white
    puts ''
    source = $config['images']['source']
    export = $config['images']['export']
    cmd = "rsync -aC #{source} #{export}" #rsync for two local paths. WHO KNEW? 
    `#{cmd}`
  end # end of IMG:SYNC
  
  desc "Reverse sync image directory from BUILD to DEV"
  task :backsync do
    puts ''
    puts ' => Syncing BUILD images to DEV images'.blue.on_white
    puts ''
    source = $config['images']['export']
    export = $config['images']['source']
    cmd = "rsync -aC #{source} #{export}"
    `#{cmd}`
  end # end of IMG:BACKSYNC
end # end of IMG tasks

# version control tasks for Subversion
namespace :svn do
  desc "Create a new tagged release in Subversion"
  task :tag do
    puts ''
    puts ' => Creating new SVN Tag for this release.'.blue.on_white
    puts ''
    build_loc = $config['svn']['repo'] + $config['svn']['path'] + $config['svn']['export']
    the_time = Time.now
    this_tag = 'FE_' + the_time.strftime('%Y-%m-%dT%H%M')
    tag_loc = $config['svn']['repo'] + 'tags/' + this_tag
    `svn copy #{build_loc} #{tag_loc} -m 'FE Build Script Autotag'`
  end # end SVN:TAG
end # end of SVN tasks

# version control tasks for Git
namespace :git do
  desc "Create a new tagged release in Git"
  task :tag do
    puts ''
    puts ' => Creating new Git Tag for this release.'.blue.on_white
    puts ''
    the_time = Time.now
    this_tag = "FE_" + the_time.strftime('%Y-%m-%dT%H%M')
    `git tag #{this_tag}`
  end # end GIT:TAG
end #end of GIT tasks

# setup help documentation
desc "Explain what needs to happen to properly install the Rakefile."
task :setup do
  puts ''
  puts ' => Hold on, forwarding you to the install instructions.     '.blue.on_white
  puts '    (You need to be in the office or on the VPN for this...) '.blue.on_white
  puts ''
  `open http://km.dev.navarts.local/wiki`
end # end SETUP

desc "Output a list of Rake tasks"
task :help do
  puts ''
  sh "rake -T"
  puts ''
end # end of HELP

task :default => "help"
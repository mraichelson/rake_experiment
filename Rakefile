##
# Some project level configuration is stored in CONFIG.YML
# Version History
# => 0.5 : Multiple revisions (2011-09-13)
#    * Bug Fix: use RegEx on the output from Juicer for url() values in CSS to fix the 
#      paths to images, etc. (It's being overly helpful)
#    * Internal feedback: added $BuildDate$ token replacement in HTML/CSS/JS files.
# => 0.4 Internal feedback revisions: RAKE SETUP now will check for the presence of the 
#    directory structures identified in CONFIG.YML and create them if they are not
#    present relative to the Rakefile. (2011-07-16)
# => 0.3 Internal testing version (2011-07-11)
# => 0.2 Internal testing version (2011-07-09)
# => 0.1 Internal testing version (2011-07-07)
##
require 'rubygems'
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
    puts ' => Merging and Compressing CSS files. '.blue.on_white
    puts ''
    source_path = $config['stylesheets']['source']
    build_path  = $config['stylesheets']['export']
    $config['stylesheets']['manage'].each { |file|
      puts "    +-> ".green + "Building " + "#{source_path}#{file}".yellow + " to " + "#{build_path}#{file}".green
      `juicer merge #{source_path}#{file} -o #{build_path}#{file} --force`
      the_file = build_path + file
      the_time = Time.now
      replace_path = '../' + $config['svn']['source'] 
      new_file = File.open(the_file, 'r') { |f|
        f.read.gsub(replace_path, '').gsub('$BuildDate$', the_time.strftime('%Y-%m-%dT%H%M'))
      }
      File.open(the_file, 'w+') { |f|
        f.puts new_file
      }
    }
    puts ''
  end # end BUILD:CSS
  
  desc 'Build HTML files from Source'
  task :html do
    puts ''
    puts ' => Building HTML files. '.blue.on_white
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
        # strip any lines of only whitespace
        # replace our $BuildDate$ token with the date and time of the build.
        the_time = Time.now
        outfile.write @doc.to_original_html.gsub(/^\s*$\n/,'').gsub('$BuildDate$', the_time.strftime('%Y-%m-%dT%H%M'))
      end
    }
    puts ''
  end # end BUILD:HTML
  
  desc 'Merge and compress JS files'
  task :js do
    puts ''
    puts ' => Merging and Compressing JS files. '.blue.on_white
    puts ''
    $config['scripts']['manage'].each { |file|
      source_path = $config['scripts']['source']
      build_path  = $config['scripts']['export']
      puts "    +-> ".green + "Building " + "#{source_path}#{file}".yellow + " to " + "#{build_path}#{file}".green
      # -s flag skips JSLint verification before merging...
      `juicer merge -s #{source_path}#{file} -o #{build_path}#{file} --force`
      the_file = build_path + file
      the_time = Time.now
      new_file = File.open(the_file, 'r') { |f|
        f.read.gsub('$BuildDate$', the_time.strftime('%Y-%m-%dT%H%M'))
      }
      File.open(the_file, 'w+') { |f|
        f.puts new_file
      }
    }
    puts ''
  end # end BUILD:JS

  desc 'Perform all Front-End build tasks'
  task :all => [:css, :html, :js] do
    puts ''
    puts ' => Performed all Build tasks. '.blue.on_green
    puts ''
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
    puts ' => Testing CSS files with W3c validator. '.blue.on_white
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
    puts ' => Testing HTML files with W3c validator. '.blue.on_white
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
    puts ' => Testing JS files with JSLint. '.blue.on_white
    puts ''
    $config['scripts']['jslint'].each { |file_to_test|
      file_to_test = $config['scripts']['source'] + file_to_test
      puts '    => Testing ' + file_to_test + ' with JSLint'
      puts ''
      # It seems really sideways to me to bounce this back out to another shell command
      # but I can't find any docs around using Juicer from within other ruby scripts...
      sh   'juicer verify ' + file_to_test
    }
    puts ''
  end # end TEST:JS

  desc 'Perform all Test tasks'
  task :all => [:css, :html, :js] do 
    puts ''
    puts ' => Performed all Test tasks. '.blue.on_green
    puts ''
  end # end TEST:ALL
end # end of TEST tasks

# image management tasks
namespace :img do
  desc 'Compress image files with ImageOptim'
  task :compress do
    puts ''
    puts ' => Launching ImageOptim to compress image files. '.blue.on_white
    puts ''
    cmd = 'open -a ImageOptim.app ' + $config['images']['source']
    `#{cmd}`
  end # end IMG:COMPRESS
  
  desc "Sync image directory from DEV to BUILD"
  task :sync do
    puts ''
    puts ' => Syncing DEV images to BUILD images '.blue.on_white
    puts ''
    source = $config['images']['source']
    export = $config['images']['export']
    cmd = "rsync -aC #{source} #{export}" #rsync for two local paths. WHO KNEW? 
    `#{cmd}`
  end # end of IMG:SYNC
  
  desc "Reverse sync image directory from BUILD to DEV"
  task :backsync do
    puts ''
    puts ' => Syncing BUILD images to DEV images '.blue.on_white
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
    puts ' => Creating new SVN Tag for this release. '.blue.on_white
    the_time = Time.now
    this_tag = 'FE_' + the_time.strftime('%Y-%m-%dT%H%M')
    tag_url_source = $config['svn']['repo'] + $config['svn']['path'] + $config['svn']['export']
    tag_url_base = $config['svn']['repo'] + 'tags/'
    default_commit_msg = 'FE Build Script Autotag'
    
    # gather user input...
    puts             ''
    puts             '    Please enter a folder name for the tag to use.'
    puts             '    (No special characters, no spaces, a-z/A-Z/0-9/-/_ only, thanks.)'
    puts             '    (If no folder is specified ' + this_tag + ' will be used.)'
    puts             ''
    tag_path =   ask('    Folder Name:'.yellow + ' ')
    puts             ''
    puts             '    Please enter a commit message to describe what this tag is for.'
    puts             '    (No single quotes/apostrophes, thanks.)'
    puts             '    (If no message is specified "' + default_commit_msg + '" will be used.)'
    puts             ''
    commit_msg = ask('    Commit Message:'.yellow + ' ')
    puts             ''

    if !tag_path.empty?
      this_tag = tag_path
    end
    if commit_msg.empty?
      commit_msg = default_commit_msg
    end
    tag_url_target = tag_url_base + this_tag

    `svn copy #{tag_url_source} #{tag_url_target} -m '#{commit_msg}'`
    puts '    +-> New tag created'.green
    puts ''
  end # end SVN:TAG
end # end of SVN tasks

# version control tasks for Git
namespace :git do
  desc "Create a new tagged release in Git"
  task :tag do
    puts ''
    puts ' => Creating new Git Tag for this release. '.blue.on_white
    puts ''
    the_time = Time.now
    this_tag = "FE_" + the_time.strftime('%Y-%m-%dT%H%M')
    
    puts           '    Please enter a name for this tag.'
    puts           '    (No special characters, no spaces, a-z/A-Z/0-9/-/_ only, thanks.)'
    puts           '    (If no name is specified ' + this_tag + ' will be used.)'
    puts           ''
    tag_name = ask('    Tag Name:'.yellow+' ')
    puts           ''
    
    if !tag_name.empty?
      this_tag = tag_name
    end
    
    `git tag #{this_tag}`
    puts "    +-> New tag is '#{this_tag}'".green
    puts ''
  end # end GIT:TAG
end #end of GIT tasks

# setup help documentation
desc "Explain what needs to happen to properly install the Rakefile."
task :setup do
  puts ''
  puts ' => Checking directory structure, if not present it will be  '.blue.on_white
  puts '    created according to CONFIG.YML                          '.blue.on_white
  
  if !File.directory?($config['svn']['source'])
    puts ''
    puts '    x-> No SOURCE directory present, creating it now.'.red
    Dir.mkdir($config['svn']['source'])
  else
    puts ''
    puts '    +-> SOURCE directory present'.green
  end
  if !File.directory?($config['html']['source'])
    puts '        x-> No HTML source directory present, creating it now.'.red
    Dir.mkdir($config['html']['source'])
  end
  if !File.directory?($config['images']['source'])
    puts '        x-> No IMAGES source directory present, creating it now.'.red
    Dir.mkdir($config['images']['source'])
  end
  if !File.directory?($config['stylesheets']['source'])
    puts '        x-> No STYLESHEETS source directory present, creating it now.'.red
    Dir.mkdir($config['stylesheets']['source'])
  end
  if !File.directory?($config['scripts']['source'])
    puts '        x-> No SCRIPTS source directory present, creating it now.'.red
    Dir.mkdir($config['scripts']['source'])
  end
  
  if !File.directory?($config['svn']['export'])
    puts ''
    puts '    x-> No BUILD directory present, creating it now.'.red
    Dir.mkdir($config['svn']['export'])
  else
    puts ''
    puts '    +-> BUILD directory present'.green
  end
  if !File.directory?($config['html']['export'])
    puts '        x-> No HTML build directory present, creating it now.'.red
    Dir.mkdir($config['html']['export'])
  end
  if !File.directory?($config['images']['export'])
    puts '        x-> No IMAGES build directory present, creating it now.'.red
    Dir.mkdir($config['images']['export'])
  end
  if !File.directory?($config['stylesheets']['export'])
    puts '        x-> No STYLESHEETS build directory present, creating it now.'.red
    Dir.mkdir($config['stylesheets']['export'])
  end
  if !File.directory?($config['scripts']['export'])
    puts '        x-> No SCRIPTS build directory present, creating it now.'.red
    Dir.mkdir($config['scripts']['export'])
  end
  
  # puts ''
  # puts ' => Hold on, forwarding you to the install instructions.     '.blue.on_white
  # puts '    (You need to be in the office or on the VPN for this...) '.blue.on_white
  # puts ''
  # `open https://www.github.com/mraichelson/rake_experiment`
  puts ''
end # end SETUP

desc "Output a list of Rake tasks"
task :help do
  puts ''
  sh "rake -T"
  puts ''
end # end of HELP

task :default => "help"

### helpers
# lifted from https://github.com/cloudhead/dorothy 
# (Rakefile for the Toto blogging engine)
def ask message
  print message
  STDIN.gets.chomp
end
# Build script experiment

## What I'd like it to do...

* Merge and compress JS files. (does this! using Juicer)
* Merge and compress CSS files. (does this! using Juicer)
* Remove and/or rewrite excess CSS/JS file references used in HTML files. (does this! using Hpricot)
* Test CSS files for W3c validation. (does this! using W3c_validators)
* Test JS files using JSLint. (does this! using Juicer)
* Test HTML files for W3c validation. (does this! using W3c_validators)
* ? Test CSS files with CSSLint? (This never really goes well for me.)
* Provide a simplified way of generating a SVN/Git tag for different releases of code.
  * SVN (does this!)
  * Git (does this!)
* Provide a hook into ImageOptim for triggering compression of image files. (does this!)
* Will clone the images directory from the dev structure into the build structure. (does this!)

Todo: 

* Installation/setup documentation

## Known issues

* The HTML validation provided by the w3c_validator gem returns an error object where all the property values are null. So I can't identify actual specific errors from the command line, only identify that the file as a whole fails validation.
* Can't colorize the output of some tasks since (most notably TEST:JS) since they're really wrappers around command line calls (Juicer didn't have any documentation around using it from within a ruby script.)

## Installation

### Terminal configuration

In Terminal open the Preferences pane. Go to Settings > Text and check the "Display ANSI colors" checkbox. (This isn't _strictly_ necessary, but without it you don't get pretty colors to help show what's going on.)

### Third-party applications

* [ImageOptim](http://imageoptim.pornel.net/) (used for image compression)

### Update the Ruby Gem package manager

Just to make sure that it's up to date and will look for all the current repository locations to pull gems from, run the following command from Terminal. 

`sudo gem update --system`

### Ruby gems

(this only needs to be done the FIRST TIME you set this up on your system)

gem install syntax: `sudo gem install {gem name}`

* [rake](http://rubyrake.org/)
* [juicer](https://github.com/cjohansen/juicer)
* [hpricot](http://hpricot.com/)
* [w3c_validators](http://code.dunae.ca/w3c_validators/)
* [colorize](http://colorize.rubyforge.org/)
* json (used by the W3c validators gem)
* Yaml (Yaml is installed by default with Ruby, you do not need to use GEM to install it.)

### Juicer config... 

* `juicer install yui_compressor`
* `juicer install jslint`

### Get down to it, yo...

Navigate to your project directory, and type `rake`. 


## External docs that may be of use

Rake tutorials

* [Official Rake documentation tutorial](http://docs.rubyrake.org/tutorial/index.html)
* [Using the Rake build language](http://martinfowler.com/articles/rake.html)
* [JasonSeifer.com](http://jasonseifer.com/2010/04/06/rake-tutorial)

## Installation on windows

The image tasks can't be used on windows. (There's no ImageOptim and the rsync options have all been pretty mediocre so far.) It's possible to find workarounds to tie into software that would run on windows, but since none of our FE devs use windows as anything but a browser testing platform I didn't figure it was worth the effort right now. 

* [Ruby 1.8.7](http://rubyinstaller.org/downloads/)
* [Ruby DevKit](http://rubyinstaller.org/downloads/)
  * [Install Instructions](https://github.com/oneclick/rubyinstaller/wiki/Development-Kit)
* [Java](http://www.java.com/) (for Rhino, used by JSlint for testing of JS files)
* [Ansicon](http://adoxa.110mb.com/ansicon/index.html) (to enable ANSI color support in cmd.exe)
  * [Ansicon install notes](http://softkube.com/blog/ansi-command-line-colors-under-windows/)
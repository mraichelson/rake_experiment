# Build script experiment

## What I'd like it to do...

* Merge and compress JS files. (does this! using Juicer)
* Merge and compress CSS files. (does this! using Juicer)
* Remove and/or rewrite excess CSS/JS file references used in HTML files. (does this! using Nokogiri)
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

## Installation

### Third-party applications

* [ImageOptim](http://imageoptim.pornel.net/)

### Ruby gems

(this only needs to be done the FIRST TIME you set this up on your system)

gem install syntax: `sudo gem install {gem name}`

* [Rake](http://rubyrake.org/)
* [Juicer](https://github.com/cjohansen/juicer)
* [Nokogiri](http://nokogiri.org/)
* [W3c_validators](http://code.dunae.ca/w3c_validators/)
* [Colorize](http://colorize.rubyforge.org/)
* Json (used by the W3c validators gem)
* Yaml (Yaml is installed by default with Ruby, it does not need to be downloaded.)

### Juicer config... 

* juicer install yui_compressor
* juicer install jslint

## External docs that may be of use

Rake tutorials

* [Official Rake documentation tutorial](http://docs.rubyrake.org/tutorial/index.html)
* [Using the Rake build language](http://martinfowler.com/articles/rake.html)
* [JasonSeifer.com](http://jasonseifer.com/2010/04/06/rake-tutorial)

## Installation on windows

The image tasks can't be used on windows. (There's no ImageOptim and the rsync options have all been pretty mediocre so far.)

* [Ruby 1.8.7](http://rubyinstaller.org/downloads/)
* [Ruby DevKit](http://rubyinstaller.org/downloads/)
  * [Install Instructions](https://github.com/oneclick/rubyinstaller/wiki/Development-Kit)
* [Java](http://www.java.com/) (for Rhino, used by JSlint for testing of JS files)
* [Ansicon](http://adoxa.110mb.com/ansicon/index.html) (to enable ANSI color support in cmd.exe)
  * [Ansicon install notes](http://softkube.com/blog/ansi-command-line-colors-under-windows/)
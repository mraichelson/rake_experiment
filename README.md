# Build Script Experiment

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

## Gems and stuff

(this only needs to be done the FIRST TIME you set this up on your system)

gem install syntax: `sudo gem install {gem name}`

* Rake
* Juicer
* Nokogiri
* W3c_validators
* Colorizer
* Yaml (Yaml is installed by default with Ruby, it does not need to be downloaded.)

### Juicer config... 

* juicer install yui_compressor
* juicer install jslint
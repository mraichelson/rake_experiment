# Build Script Experiment

Todo: 

* a bunch of stuff...

To consider:

* Would using Juicer internals for more of the CSS/JS management tasks be a better path?
  * @depends directive in JS comment block for what files to merge combined with Nokogiri stripping of excess SCRIPT tags could be a way to manage what scripts get included where and in what format. 
  * @import directives in CSS are processed into a single file, so a single LINK to an file using multiple @imports for local dev would be a single LINK to a single merged file in the build environment.

## Gems to definitely use: 

* Rake (duh)
* Juicer
* Yaml
* Nokogiri
* W3c_validators

## Juicer config: 

* juicer install yui_compressor
* juicer install jslint

## Possibly use: 

* Bundler (http://gembundler.com/)
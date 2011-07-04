#!/usr/bin/ruby
require 'rubygems'
require 'nokogiri'

f = File.open("../_source/html/01-pageTypeX.html")
@doc = Nokogiri::HTML(f)
f.close

puts ' '
puts '-- ORIGINAL FILE CONTENT --'
puts @doc.to_html

#remove managed CSS files
managed_styles = @doc.css('link.managed')
managed_styles.remove

# remove managed JS files
managed_scripts = @doc.css('script.managed')
managed_scripts.remove

# ? replace the placeholder for CSS files
# ? replace the placeholder for JS files

puts ' '
puts '-- MODIFIED FILE CONTENT --'
puts @doc.to_html
puts ' '
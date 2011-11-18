#!/usr/bin/env ruby
require 'rubygems'
require 'trollop'

opts = Trollop::options do
  # opt :http_1_0, "Force HTTP/1.0"
  # opt :http_1_1, "Force HTTP/1.1"
  # opt :hide_referer, "Hide referer", :default => true
  # opt :connections, "Set number of simultaneous connections", :default => 2
end

output = %x[ ssh bb2 findhotspot ]
lines = output.split("\n").select { |line| line =~ /\d*\.\d*\.\d*\.\d*,.*,.*,.*/ }
filtered_lines = lines.select { |line| line =~ /.*#{search_by}.*/ }

#!/usr/bin/env ruby
# puts ARGV[0] or "config/environment"
# env_path = ARGV[0] or "config/environment"
env_path = "config/environment.rb"
require env_path

Dir.glob("app/models/*rb") { |f| require f }

puts "digraph x {"

Dir.glob("app/models/*rb") do |f|
  f.match(/\/([a-z_]+).rb/)
  classname = $1.camelize
  klass = Kernel.const_get classname

  if klass.superclass == ActiveRecord::Base
    puts classname
    klass.reflect_on_all_associations.each { |a|
      puts classname + " -> " + a.name.to_s.camelize.singularize + " [label="+a.macro.to_s+"]"
    }
  end
end
puts "}"

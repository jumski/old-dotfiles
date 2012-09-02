
def model_names
  Dir['app/models/*.rb'].map do |path|
    names = path.scan(/app\/models\/(.*)\.rb/).flatten.sort.uniq
    names
  end.sort.flatten
end

def models
  model_names.map { |name| name.camelize.constantize }
end

def model_counts
  model_names.each do |model|
    puts "=== #{model.pluralize} = #{model.camelize.constantize.count}"
  end

  models.map do |model|
    {model.name => model.count}
  end
end

def puts_model_counts
  puts models.map{|m| "#{m}=#{m.count}"}.sort.join("\n")
end

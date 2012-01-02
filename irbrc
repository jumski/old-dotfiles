
def desc(model)
  y model.columns.map(&:name)
end

def reqs(model)
  required = model.columns.reject{|c| c.null}.map(&:name)
  required.delete('id')

  puts "Required columns:"
  if required
    y required
  else
    puts " -- All columns are optional"
  end
end

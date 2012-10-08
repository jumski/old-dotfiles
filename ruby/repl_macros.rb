
def desc(model)
  pp model.columns.map(&:name)
end

def reqs(model)
  required = model.columns.reject{|c| c.null}.map(&:name)
  required.delete('id')

  puts "Required columns:"
  if required
    pp required
  else
    puts " -- All columns are optional"
  end
end


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

def _hash(num = 3)
  _arr(num).reduce({}) do |hash, letter|
    hash[letter.to_sym] = letter.upcase
    hash
  end
end

def _arr(num = 3)
    ('a'..'z').to_a[0, num]
end

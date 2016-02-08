
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

def conjune(hours, usdpln = 3.95)
  raise 'calm your tits' unless $calm_tits == true
  hours * 30 * usdpln * 0.81
end

def monk(hours, eurpln = 4.05)
  raise 'calm your tits' unless $calm_tits == true
  hours * 20 * eurpln * 0.81
end

def rebased(hours, plnhr = 110)
  raise 'calm your tits' unless $calm_tits == true
  hours * plnhr * 0.81
end

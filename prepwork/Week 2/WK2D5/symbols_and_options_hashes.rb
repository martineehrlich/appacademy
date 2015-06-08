def superprint(string, options = {})
  defaults = {:times => 2, :upcase => true, :reverse => true}
  options = defaults.merge(options)
string.upcase! if options[:upcase] == true
string.reverse! if options[:reverse] == true

string * options[:times]
end

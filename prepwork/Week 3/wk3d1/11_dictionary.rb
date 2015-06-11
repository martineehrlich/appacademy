class Dictionary
  attr_accessor :entries

  def initialize
    @entries = {}
  end

  def add(entry)
    if entry.is_a? Hash
    @entries.merge!(entry)
    else entry.split.map {|key| @entries[key] = nil}
    end
  end

  def keywords
    sorted = entries.map {|k, v| k}.sort
  end

  def include?(entry)
    @entries.include?(entry)
  end

  def find(key)
    if @entries.empty?
        {}
    else
      @entries.select do |k, v|
        k[0...key.length] == key
      end
    end
  end

  def printable
    @entries.sort.map { |k, v| "[#{k}] \"#{v}\""}.join("\n")
  end

end

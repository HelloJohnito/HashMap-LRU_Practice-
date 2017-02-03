class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash = size
    i = 1
    self.each do |el|
      hash ^= (el % i)
      i += 1
    end
    hash
  end
end

class String
  def hash
    hash = 0
    i = 1
    self.bytes do |byte|
      hash ^= (byte % i)
      i += 1
    end
    hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash = size
    sorted_keys = keys.sort { |a,b| a.to_s <=> b.to_s }
    i = size + 1
    sorted_keys.each do |key|
      val = self[key]
      hash ^= key.hash ^ (val.hash % i)
      i += 1
    end
    hash
  end
end

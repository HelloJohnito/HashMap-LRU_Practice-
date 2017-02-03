class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash = size
    self.each do |el|
      hash ^= el.hash
    end
    hash
  end
end

class String
  def hash
    hash = 0
    m = 16
    a = 0.5 * (Math.sqrt(5) - 1)
    i = 1
    self.bytes do |byte|
      x = (byte * a)
      x = x.to_i
      hash ^= (m * x).floor ^ (x % i) ^ (2 * hash / i)
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
      hash ^= key.to_s.hash ^ (val.to_s.hash + i)
      i += 1
    end
    p hash
    hash
  end
end

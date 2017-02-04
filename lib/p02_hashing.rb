class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash = size
    self.each_with_index do |el, i|
      hash ^= (el.hash + i)
    end
    hash
  end
end

class String
  def hash
    hash = size
    i = 1
    self.bytes do |byte|
      hash ^= (byte + i).hash
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
    i = 1
    sorted_keys.each do |key|
      val = self[key]
      xor = ((key.to_s.hash + (3 * i)) ^ (val.to_s.hash * i))
      hash = hash ^ xor
    end
    hash
  end
end

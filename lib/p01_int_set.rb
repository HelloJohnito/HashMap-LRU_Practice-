class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max) { false }
  end

  def remove(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = false
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true
  end

  def include?(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @max)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = self[num]
    @store[bucket] << num unless @store[bucket].include?(num)
  end

  def remove(num)
    @store[self[num]].delete(num)
  end

  def include?(num)
    @store[self[num]].include?(num)
  end

  private

  def [](num)
    num % num_buckets
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return if include?(num)
    @store[self[num]] << num
    @count += 1
    resize! unless count < num_buckets
  end

  def remove(num)
    return unless include?(num)
    @store[self[num]].delete(num)
    @count -= 1
  end

  def include?(num)
    @store[self[num]].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num % num_buckets
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_bucket_count = num_buckets * 2
    new_store = Array.new(new_bucket_count) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        new_store[el % new_bucket_count] << el
      end
    end

    @store = new_store
  end
end

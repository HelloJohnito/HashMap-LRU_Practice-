require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return if include?(key)
    @count += 1
    @store[self[key]] << key
    resize! unless @count < num_buckets
  end

  def include?(key)
    @store[self[key]].include?(key)
  end

  def remove(key)
    return unless include?(key)
    @count -= 1
    @store[self[key]].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num.hash % num_buckets
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = num_buckets * 2
    new_store = Array.new(new_buckets) { Array.new}
    @store.each do |bucket|
      bucket.each do |key|
        index = key.hash % new_buckets
        new_store[index] << key
      end
    end
    @store = new_store
  end
end

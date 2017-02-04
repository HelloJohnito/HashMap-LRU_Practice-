require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    @count += 1 if @store[bucket(key)].append(key, val)
    resize! unless count < num_buckets
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    @count -= 1 unless @store[bucket(key)].remove(key).nil?
  end

  def each
    return unless block_given?
    @store.each do |bucket|
      bucket.each do |el|
        yield(el.key, el.val)
      end
    end
    self
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = num_buckets * 2
    new_store = Array.new(new_buckets) { LinkedList.new }
    each do |key, val|
      new_store[bucket(key)].append(key, val)
    end
    @store = new_store
    nil
  end

  def bucket(key)
    key.hash % num_buckets
  end
end

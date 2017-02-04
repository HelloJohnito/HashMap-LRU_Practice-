class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def next_s
    "#{@next.to_s}"
  end

  def prev_s
    "#{@prev.to_s}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    raise "error" if @prev.nil? || @next.nil?
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each do |current|
      return current.val if current.key == key
    end
    nil
  end

  def include?(key)
    each do |current|
      return true if current.key == key
    end
    false
  end

  def append(key, val)
    if include?(key)
      update(key,val)
      return false
    end

    new_link = Link.new(key, val)
    last.next = new_link
    new_link.prev = last
    @tail.prev = new_link
    new_link.next = @tail
    true
  end

  def update(key, val)
    each do |current|
      if current.key == key
        current.val = val
        break
      end
    end
    nil
  end

  def remove(key)
    each do |current|
      if current.key == key
        current.remove
        return key
      end
    end
    nil
  end

  def each
    return unless block_given?
    current = first
    until current == @tail
      yield(current)
      current = current.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end

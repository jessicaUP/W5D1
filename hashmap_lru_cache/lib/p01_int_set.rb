require 'byebug'

class MaxIntSet

  attr_accessor :store
  attr_reader :max

  def initialize(max)
    @store = Array.new(max+1, false) #[false, false, false]
    @max = max
  end

  def insert(num)
    raise 'Out of bounds' if !is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    (num <= @max && num > 0)
  end

  def validate!(num)
  end
end


class IntSet

  attr_reader :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    if self.include?(num)
      bucket = self[num]
      i = bucket.index(num)
      return bucket.delete_at(i)
    end
  end

  def include?(num)
    bucket = self[num] 
    bucket.each { |ele| return true if ele == num }
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num` 
    bucket_idx = num % num_buckets
    @store[bucket_idx]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless self.include?(num)
      self[num] << num
      @count += 1
      resize! if @count >= num_buckets
    end
  end

  def remove(num)
    if self.include?(num)
      i = self[num].index(num)
      self[num].delete_at(i)
      @count -= 1
    end
  end

  def include?(num)
    self[num].each { |ele| return true if ele == num }  #array bucket
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    bucket_idx = num % num_buckets
    @store[bucket_idx]
  end

  def num_buckets
    @store.length
  end

  def resize!
    nums = @store.flatten
    @store = Array.new(num_buckets*2) { Array.new } # O(1)
    @count = 0
    nums.each { |num| self.insert(num) } # O(n)
  end
end

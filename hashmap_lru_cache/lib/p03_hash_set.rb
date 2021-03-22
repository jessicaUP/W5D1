class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash
    unless self.include?(key)
      self[num] << key
      @count += 1
      resize! if @count == num_buckets
    end
  end

  def include?(key)
    num = key.hash
    self[num].each { |ele| return true if ele == key }
    false
  end

  def remove(key)
    num = key.hash
    if self.include?(key)
      i = self[num].index(key)
      self[num].delete_at(i)
      @count -= 1
    end
  end

  private

  def [](num)  #num => the hash code
    # optional but useful; return the bucket corresponding to `num`
    bucket_idx = num % num_buckets
    @store[bucket_idx]
  end

  def num_buckets
    @store.length
  end

  def resize!
    keys = @store.flatten
    @store = Array.new(num_buckets*2) { Array.new }
    @count = 0
    keys.each { |key| self.insert(key) }
  end
end

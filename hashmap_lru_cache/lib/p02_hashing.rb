class Integer
  # Integer#hash already implemented for you
end

class Array #ordering is important
  def hash
    nums = []
    self.each_with_index do |ele,i|
      if ele.is_a?(String)
        nums << ele.hash
      elsif ele.is_a?(Integer)
        nums << ele
      elsif ele.is_a?(Array)
        nums << ele.length * 2393
      elsif ele.is_a?(Boolean)
        nums << 875*nums[-1] if true
        nums << 769*nums[0] if false
      end
    end
    nums.join("").to_i.hash
  end
end

class String #ordering is not important
  def hash
    self.bytes.join("").to_i.hash
  end
end

class Hash #ordering is important
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    num = 0
    self.each_key do |k|
      if k.is_a?(String)
        num += k.hash
      elsif k.is_a?(Integer)
        num += k
      elsif k.is_a?(Array)
        num += k.length * 2393
      end
    end
    self.each_value do |v|
      if v.is_a?(String)
        num += v.hash
      elsif v.is_a?(Integer)
        num += v
      elsif v.is_a?(Array)
        num += v.length * 2393
      elsif v.is_a?(Boolean)
        num += 4550 if true
        num += 9822 if false
      end
    end
    num.hash
    # 0
  end
end

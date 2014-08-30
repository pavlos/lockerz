class Locker

  attr_reader :size
  attr_reader :bag

  def initialize(size)
    raise RangeError unless Sizes::ALL.include? size
    @size = size
    @bag = nil
  end

  def accept_bag(bag)
    raise RangeError, "bag is too big" if bag.size > self.size
    raise BagExists if @bag
    @bag = bag
  end

  def return_bag
    bag = @bag
    @bag = nil
    bag
  end

end
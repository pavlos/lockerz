class Bag

  attr_reader :size

  def initialize(size)
    raise RangeError unless Sizes::ALL.include? size
    @size = size
  end

end
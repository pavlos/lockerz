class Locker
  LOCKER_SIZE_SMALL = 1
  LOCKER_SIZE_MEDIUM = 2
  LOCKER_SIZE_LARGE = 3

  SIZES = [LOCKER_SIZE_SMALL, LOCKER_SIZE_MEDIUM, LOCKER_SIZE_LARGE]
  attr_reader :size

  def initialize(size)
    raise RangeError unless SIZES.include? size
    @size = size
  end

end
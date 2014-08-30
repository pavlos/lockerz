class LockerManager

  attr_reader :lockers
  attr_reader :empty_lockers

  def initialize(small, medium, large)
    @lockers = {}
    @empty_lockers = { Sizes::SMALL  => [],
                      Sizes::MEDIUM => [],
                      Sizes::LARGE  => []
    }

    small.times do |i|
      locker_id = "S#{i}"
      @lockers[locker_id] = Locker.new(Sizes::SMALL)
      @empty_lockers[Sizes::SMALL] << locker_id
    end

    medium.times do |i|
      locker_id = "M#{i}"
      @lockers[locker_id] = Locker.new(Sizes::MEDIUM)
      @empty_lockers[Sizes::MEDIUM] << locker_id
    end

    large.times do |i|
      locker_id = "L#{i}"
      @lockers[locker_id] = Locker.new(Sizes::LARGE)
      @empty_lockers[Sizes::LARGE] << locker_id
    end

  end

  def accept_bag(bag)
    locker_size = bag.size
    locker_id = nil

    while locker_id.nil? && locker_size <= Sizes::LARGE
      locker_id = @empty_lockers[locker_size].pop
      locker_size += 1
    end

    raise OutOfLockers, 'There are no more available lockers' if locker_id.nil?
    @lockers[locker_id].accept_bag(bag)
    locker_id
  end

  def return_bag(locker_id)
    bag = @lockers[locker_id].return_bag
    @empty_lockers[bag.size] << locker_id if bag
    bag
  end

end
require 'spec_helper'

describe Locker do
  describe 'creating a locker' do

    it 'should allow small, medium, large' do
      sizes = [Locker::LOCKER_SIZE_SMALL, Locker::LOCKER_SIZE_MEDIUM, Locker::LOCKER_SIZE_LARGE]
      sizes.each do |size|
        locker = Locker.new(size)
        locker.size.should be size
      end
    end


    it 'should raise an exception if size is out of range' do
      expect{Locker.new('trenta')}.to raise_error(RangeError)
    end

  end
end
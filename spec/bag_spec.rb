require 'spec_helper'

describe Bag do
  describe 'creating a locker' do

    it 'should allow small, medium, large' do
      sizes = [Sizes::SMALL, Sizes::MEDIUM, Sizes::LARGE]
      sizes.each do |size|
        locker = Bag.new(size)
        locker.size.should be size
      end
    end


    it 'should raise an exception if size is out of range' do
      expect{Bag.new('trenta')}.to raise_error(RangeError)
    end

  end
end
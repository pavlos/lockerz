require 'spec_helper'

describe Locker do
  describe 'creating a locker' do
    it 'should allow small, medium, large' do
      sizes = [Sizes::SMALL, Sizes::MEDIUM, Sizes::LARGE]
      sizes.each do |size|
        locker = Locker.new(size)
        locker.size.should be size
      end
    end

    it 'should raise an exception if size is out of range' do
      expect{Locker.new('trenta')}.to raise_error(RangeError)
    end
  end

  context 'baggage handling' do
    let(:locker) { Locker.new(Sizes::MEDIUM)}

    describe 'accept_bag' do

      it 'should raise an exception if the bag is too big' do
        b = Bag.new(Sizes::LARGE)
        expect {locker.accept_bag b}.to raise_error(RangeError)
      end

      it 'should raise an exception if the locker already has a bag' do
        b = Bag.new(Sizes::MEDIUM)
        b2 = Bag.new(Sizes::MEDIUM)
        locker.accept_bag b
        expect {locker.accept_bag b2}.to raise_error(BagExists)
      end

      it 'it should accept the bag if the locker is the same size as the bag' do
        b = Bag.new(Sizes::MEDIUM)
        locker.accept_bag b
        locker.bag.should be b
      end

      it 'should accept the bag if the locker is bigger than the bag' do
        b = Bag.new(Sizes::SMALL)
        locker.accept_bag b
        locker.bag.should be b
      end
    end

    describe 'give_bag' do
      context 'locker has bag' do
        let(:bag) {Bag.new(Sizes::SMALL)}

        before do
          locker.accept_bag bag
        end

        it 'should return the bag' do
          locker.return_bag.should be bag
        end

        it 'should lose the reference to the bag'  do
          locker.return_bag.should be bag
          locker.bag.should be nil
        end
      end

      context 'locker has no bag' do
        it 'should return nil' do
          locker.return_bag.should be nil
        end
      end
    end

  end

end
require 'spec_helper'

describe LockerManager do

  let(:small_lockers) {1000}
  let(:medium_lockers) {1000}
  let(:large_lockers) {1000}
  let(:manager) {LockerManager.new(small_lockers,medium_lockers,large_lockers)}

  describe 'creating an instance' do
    it 'should keep a hash of lockers' do
      small_lockers.times do |i|
        manager.lockers["S#{i}"].size.should be Sizes::SMALL
      end

      medium_lockers.times do |i|
        manager.lockers["M#{i}"].size.should be Sizes::MEDIUM
      end

      large_lockers.times do |i|
        manager.lockers["L#{i}"].size.should be Sizes::LARGE
      end
    end

    it 'should keep an index of empty lockers' do
      small_lockers.times do |i|
        manager.empty_lockers[Sizes::SMALL].should include("S#{i}")
      end

      medium_lockers.times do |i|
        manager.empty_lockers[Sizes::MEDIUM].should include("M#{i}")
      end

      large_lockers.times do |i|
        manager.empty_lockers[Sizes::LARGE].should include("L#{i}")
      end
    end
  end


  describe "managing bags" do
    let(:bag){Bag.new(Sizes::MEDIUM)}
    let(:locker_id) {"M#{medium_lockers-1}"}

    describe '#accept_bag' do
      it 'should return a locker id' do
        manager.accept_bag(bag).should == locker_id
      end

      it 'should put the bag in the locker' do
        expect(manager.lockers[locker_id]).to receive(:accept_bag).with(bag)
        manager.accept_bag(bag)
      end

      it 'should remove the locker from the list of empty lockers' do
        manager.accept_bag(bag)
        manager.empty_lockers[Sizes::MEDIUM].should_not include(locker_id)
      end

      it 'should be able to put a bag in a larger locker if all lockers are taken' do
        medium_lockers.times do
          manager.accept_bag(Bag.new(Sizes::MEDIUM))
        end
        manager.empty_lockers[Sizes::MEDIUM].length.should be 0
        manager.accept_bag(Bag.new(Sizes::MEDIUM)).should == "L#{large_lockers-1}"
      end

      it "should raise an exception if it's completely out of usable lockers" do
        large_lockers.times do
          manager.accept_bag(Bag.new(Sizes::LARGE))
        end
        expect {manager.accept_bag(Bag.new(Sizes::LARGE))}.to raise_error OutOfLockers
      end
    end

    describe '#return_bag' do

      it 'should accept a locker id and return a bag' do
        locker_id = manager.accept_bag(bag)
        manager.return_bag(locker_id).should be bag
      end

      it 'should add the locker to the list of empty lockers' do
        locker_id = manager.accept_bag(bag)
        manager.empty_lockers[Sizes::MEDIUM].should_not include(locker_id)
        manager.return_bag(locker_id)
        manager.empty_lockers[Sizes::MEDIUM].should include(locker_id)
      end

      it "should return nil if there's no bag in the locker" do
        manager.return_bag(locker_id).should be nil
      end
    end
  end


end
# Your code here
require 'weapons/bow'

describe Bow do

  before do
    allow(STDOUT).to receive(:puts)
  end

  let(:b){ Bow.new }

  describe "#arrows" do
    it 'arrow count is readable' do
      expect{ b.arrows }.not_to raise_error
    end
  end

  describe "#initialize" do
    it 'starts with 10 arrows by default' do
      expect(b.arrows).to eq(10)
    end

    it 'accepts and stores arrow count on init' do
      b_set = Bow.new(3)
      expect(b_set.arrows).to eq(3)
    end

  end

  describe '#use' do
    it 'using a bow reduces arrows by 1' do
      b.use
      expect(b.arrows).to eq(9)
    end
    it 'using a bow with 0 arrows throws an error' do
      b_none = Bow.new(0)
      expect{b_none.use}.to raise_error( 'Out of arrows')
    end
  end
end
